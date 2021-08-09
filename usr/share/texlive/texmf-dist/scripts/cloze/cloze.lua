if not modules then modules = { } end modules ['cloze'] = {
  version   = '0.1',
  comment   = 'cloze',
  author    = 'Josef Friedrich, R.-M. Huber',
  copyright = 'Josef Friedrich, R.-M. Huber',
  license   = 'The LaTeX Project Public License Version 1.3c 2008-05-04'
}
local nodex = {}
local registry = {}
registry.user_id = 3121978
registry.storage = {}
registry.defaults = {
  ['align'] = 'l',
  ['distance'] = '1.5pt',
  ['hide'] = false,
  ['linecolor'] = '0 0 0 rg 0 0 0 RG', -- black
  ['margin'] = '3pt',
  ['resetcolor'] = '0 0 0 rg 0 0 0 RG', -- black
  ['show_text'] = true,
  ['show'] = true,
  ['textcolor'] = '0 0 1 rg 0 0 1 RG', -- blue
  ['thickness'] = '0.4pt',
  ['width'] = '2cm',
}
registry.global_options = {}
registry.local_options = {}
local cloze = {}
cloze.status = {}
local base = {}
base.is_registered = {}
function nodex.create_colorstack(data)
  if not data then
    data = '0 0 0 rg 0 0 0 RG' -- black
  end
  local whatsit = node.new('whatsit', 'pdf_colorstack')
  whatsit.stack = 0
  whatsit.data = data
  return whatsit
end
function nodex.create_color(option)
  local data
  if option == 'line' then
    data = registry.get_value('linecolor')
  elseif option == 'text' then
    data = registry.get_value('textcolor')
  elseif option == 'reset' then
    data = nil
  else
    data = nil
  end
  return nodex.create_colorstack(data)
end
function nodex.create_line(width)
  local rule = node.new(node.id('rule'))
  local thickness = tex.sp(registry.get_value('thickness'))
  local distance = tex.sp(registry.get_value('distance'))
  rule.depth = distance + thickness
  rule.height = - distance
  rule.width = width
  return rule
end
function nodex.insert_list(position, current, list, head)
  if not head then
    head = current
  end
  for i, insert in ipairs(list) do
    if position == 'after' then
      head, current = node.insert_after(head, current, insert)
    elseif position == 'before' then
      head, current = node.insert_before(head, current, insert)
    end
  end
  return current
end
function nodex.insert_line(current, width)
  return nodex.insert_list(
    'after',
    current,
    {
      nodex.create_color('line'),
      nodex.create_line(width),
      nodex.create_color('reset')
    }
  )
end
function nodex.write_line()
  node.write(nodex.create_color('line'))
  node.write(nodex.create_line(tex.sp(registry.get_value('width'))))
  node.write(nodex.create_color('reset'))
end
function nodex.create_linefil()
  local glue = node.new('glue')
  glue.subtype = 100
  glue.stretch = 65536
  glue.stretch_order = 3
  local rule = nodex.create_line(0)
  rule.dir = 'TLT'
  glue.leader = rule
  return glue
end
function nodex.write_linefil()
  node.write(nodex.create_color('line'))
  node.write(nodex.create_linefil())
  node.write(nodex.create_color('reset'))
end
function nodex.create_kern(width)
  local kern = node.new(node.id('kern'))
  kern.kern = width
  return kern
end
function nodex.strut_to_hlist(hlist)
  local n = {} -- node
  n.head = hlist.head
  n.kern = nodex.create_kern(0)
  n.strut = node.insert_before(n.head, n.head, n.kern)
  hlist.head = n.head.prev
  return hlist, n.strut, n.head
end
function nodex.write_margin()
  local kern = nodex.create_kern(tex.sp(registry.get_value('margin')))
  node.write(kern)
end
function nodex.search_hlist(head)
  while head do
    if head.id == node.id('hlist') and head.subtype == 1 then
      return nodex.strut_to_hlist(head)
    end
    head = head.next
  end
  return false
end
function registry.create_marker(index)
  local marker = node.new('whatsit','user_defined')
  marker.type = 100 -- number
  marker.user_id = registry.user_id
  marker.value = index
  return marker
end
function registry.write_marker(mode, position)
  local index = registry.set_storage(mode, position)
  local marker = registry.create_marker(index)
  node.write(marker)
end
function registry.is_marker(item)
  if item.id == node.id('whatsit')
    and item.subtype == node.subtype('user_defined')
    and item.user_id == registry.user_id then
    return true
  else
    return false
  end
end
function registry.check_marker(item, mode, position)
  local data = registry.get_marker_data(item)
  if data and data.mode == mode and data.position == position then
    return true
  else
    return false
  end
end
function registry.get_marker(item, mode, position)
  local out
  if registry.check_marker(item, mode, position) then
    out = item
  else
    out = false
  end
  if out and position == 'start' then
    registry.get_marker_values(item)
  end
  return out
end
function registry.get_marker_data(item)
  if item.id == node.id('whatsit')
    and item.subtype == node.subtype('user_defined')
    and item.user_id == registry.user_id then
    return registry.get_storage(item.value)
  else
    return false
  end
end
function registry.get_marker_values(marker)
  local data = registry.get_marker_data(marker)
  registry.local_options = data.values
  return data.values
end
function registry.remove_marker(marker)
  if registry.is_marker(marker) then node.remove(marker, marker) end
end
function registry.get_index()
  if not registry.index then
    registry.index = 0
  end
  registry.index = registry.index + 1
  return registry.index
end
function registry.set_storage(mode, position)
  local index = registry.get_index()
  local data = {
    ['mode'] = mode,
    ['position'] = position
  }
  data.values = registry.local_options
  registry.storage[index] = data
  return index
end
function registry.get_storage(index)
  return registry.storage[index]
end
function registry.set_option(key, value)
  if value == '' or value == '\\color@ ' then
    return false
  end
  if registry.is_global == true then
    registry.global_options[key] = value
  else
    registry.local_options[key] = value
  end
end
function registry.set_is_global(value)
  registry.is_global = value
end
function registry.unset_local_options()
  registry.local_options = {}
end
function registry.unset_global_options()
  registry.global_options = {}
end
function registry.get_value(key)
  if registry.has_value(registry.local_options[key]) then
    return registry.local_options[key]
  end
  if registry.has_value(registry.global_options[key]) then
    return registry.global_options[key]
  end
  return registry.defaults[key]
end
function registry.get_value_show()
  if
    registry.get_value('show') == true
  or
    registry.get_value('show') == 'true'
  then
    return true
  else
    return false
  end
end
function registry.has_value(value)
  if value == nil or value == '' or value == '\\color@ ' then
    return false
  else
    return true
  end
end
function registry.get_defaults(option)
  return registry.defaults[option]
end
function cloze.basic_make(start, stop)
  local n = {}
  local l = {}
  n.head = start
  if not start or not stop then
    return
  end
  n.start = start
  n.stop = stop
  l.width = node.dimensions(
    cloze.status.hlist.glue_set,
    cloze.status.hlist.glue_sign,
    cloze.status.hlist.glue_order,
    n.start,
    n.stop
  )
  n.line = nodex.insert_line(n.start, l.width)
  n.color_text = nodex.insert_list('after', n.line, {nodex.create_color('text')})
  if registry.get_value_show() then
    nodex.insert_list('after', n.color_text, {nodex.create_kern(-l.width)})
    nodex.insert_list('before', n.stop, {nodex.create_color('reset')}, n.head)
  else
    n.line.next = n.stop.next
    n.stop.prev = n.line.prev
  end
  registry.remove_marker(n.start)
  registry.remove_marker(n.stop)
end
function cloze.basic_search_stop(head)
  local stop
  while head do
    cloze.status.continue = true
    stop = head
    if registry.check_marker(stop, 'basic', 'stop') then
      cloze.status.continue = false
      break
    end
    head = head.next
  end
  return stop
end
function cloze.basic_search_start(head)
  local start
  local stop
  local n = {}
  if cloze.status.continue then
    n.hlist = nodex.search_hlist(head)
    if n.hlist then
      cloze.status.hlist = n.hlist
      start = cloze.status.hlist.head
    end
  elseif registry.check_marker(head, 'basic', 'start') then
    start = head
  end
  if start then
    stop = cloze.basic_search_stop(start)
    cloze.basic_make(start, stop)
  end
end
function cloze.basic_recursion(head)
  while head do
    if head.head then
      cloze.status.hlist = head
      cloze.basic_recursion(head.head)
    else
      cloze.basic_search_start(head)
    end
      head = head.next
  end
end
function cloze.basic(head)
  cloze.status.continue = false
  cloze.basic_recursion(head)
  return head
end
function cloze.fix_length(start, stop)
  local l = {}
  l.width = tex.sp(registry.get_value('width'))
  l.text_width = node.dimensions(start, stop)
  l.align = registry.get_value('align')
  if l.align == 'right' then
    l.kern_start = - l.text_width
    l.kern_stop = 0
  elseif l.align == 'center' then
    l.half = (l.width - l.text_width) / 2
    l.kern_start = - l.half - l.text_width
    l.kern_stop = l.half
  else
    l.kern_start = - l.width
    l.kern_stop = l.width - l.text_width
  end
  return l.width, l.kern_start, l.kern_stop
end
function cloze.fix_make(start, stop)
  local l = {} -- length
  local n = {} -- node
  l.width, l.kern_start, l.kern_stop = cloze.fix_length(start, stop)
  n.line = nodex.insert_line(start, l.width)
  if registry.get_value_show() then
    nodex.insert_list(
      'after',
      n.line,
      {
        nodex.create_kern(l.kern_start),
        nodex.create_color('text')
      }
    )
    nodex.insert_list(
      'before',
      stop,
      {
        nodex.create_color('reset'),
        nodex.create_kern(l.kern_stop)
      },
      start
    )
  else
    n.line.next = stop.next
  end
  registry.remove_marker(start)
  registry.remove_marker(stop)
end
function cloze.fix_recursion(head)
  local n = {} -- node
  n.start, n.stop = false
  while head do
    if head.head then
      cloze.fix_recursion(head.head)
    else
      if not n.start then
        n.start = registry.get_marker(head, 'fix', 'start')
      end
      if not n.stop then
        n.stop = registry.get_marker(head, 'fix', 'stop')
      end
      if n.start and n.stop then
        cloze.fix_make(n.start, n.stop)
        n.start, n.stop = false
      end
    end
    head = head.next
  end
end
function cloze.fix(head)
  cloze.fix_recursion(head)
  return head
end
function cloze.par(head)
  local l = {} -- length
  local n = {} -- node
  for hlist in node.traverse_id(node.id('hlist'), head) do
    for whatsit in node.traverse_id(node.id('whatsit'), hlist.head) do
      registry.get_marker(whatsit, 'par', 'start')
    end
    l.width = hlist.width
    hlist, n.strut, n.head = nodex.strut_to_hlist(hlist)
    n.line = nodex.insert_line(n.strut, l.width)
    if registry.get_value_show() then
      nodex.insert_list(
        'after',
        n.line,
        {
          nodex.create_kern(-l.width),
          nodex.create_color('text')
        }
      )
      nodex.insert_list(
        'after',
        node.tail(head),
        {nodex.create_color('reset')}
      )
    else
      n.line.next = nil
    end
  end
  return head
end
function base.register(mode)
  local basic
  if mode == 'par' then
    luatexbase.add_to_callback(
      'post_linebreak_filter',
      cloze.par,
      mode
    )
    return true
  end
  if not base.is_registered[mode] then
    if mode == 'basic' then
      luatexbase.add_to_callback(
        'post_linebreak_filter',
        cloze.basic,
        mode
      )
    elseif mode == 'fix' then
      luatexbase.add_to_callback(
        'pre_linebreak_filter',
        cloze.fix,
        mode
      )
    else
      return false
    end
    base.is_registered[mode] = true
  end
end
function base.unregister(mode)
  if mode == 'basic' then
    luatexbase.remove_from_callback('post_linebreak_filter', mode)
  elseif mode == 'fix' then
    luatexbase.remove_from_callback('pre_linebreak_filter', mode)
  else
    luatexbase.remove_from_callback('post_linebreak_filter', mode)
  end
end
base.linefil = nodex.write_linefil
base.line = nodex.write_line
base.margin = nodex.write_margin
base.set_option = registry.set_option
base.set_is_global = registry.set_is_global
base.unset_local_options = registry.unset_local_options
base.reset = registry.unset_global_options
base.get_defaults = registry.get_defaults
base.marker = registry.write_marker
return base
