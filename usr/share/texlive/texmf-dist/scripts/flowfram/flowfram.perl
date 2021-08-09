#!/usr/bin/perl
# Debian required shebang above
# Original shebang below
# #!/usr/bin/env perl
# File          : flowfram.perl
# Author        : Nicola L C Talbot
# Date          : 28 June 2008
# Last Modified : 1 July 2008
# Version       : 1.0
# Description   : LaTeX2HTML implementation of the flowfram package.
#                 This is not meant to emulate the flowfram package.
#                 Most of the frame related commands are ignored, to
#                 provide a simple HTML version of the document.
#
# Copyright 2007 Nicola L.C. Talbot
#
# This work may be distributed and/or modified under the
# conditions of the LaTeX Project Public License, either version 1.3
# of this license of (at your option) any later version.
# The latest version of this license is in
#   http://www.latex-project.org/lppl.txt
# and version 1.3 or later is part of all distributions of LaTeX
# version 2005/12/01 or later.
#
# This work has the LPPL maintenance status `maintained'.
#
# The Current Maintainer of this work is Nicola Talbot.

package main;

$showstaticcontents = 0;
$showdynamiccontents = 0;

sub do_cmd_onecolumninarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_twocolumninarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_Ncolumninarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_Ncolumn{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_onecolumntopinarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_twocolumntopinarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_Ncolumntopinarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_onecolumnbottominarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_twocolumnbottominarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_Ncolumnbottominarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_onecolumnStopinarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_onecolumnDtopinarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_onecolumnSbottominarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_onecolumnDbottominarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_twocolumnStopinarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_twocolumnDtopinarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_twocolumnSbottominarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_twocolumnDbottominarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_NcolumnDbottominarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_NcolumnSbottominarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_onecolumntop
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_twocolumntop
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_Ncolumntop
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_onecolumnStop
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_twocolumnStop
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_NcolumnStop
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_onecolumnDtop
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_twocolumnDtop
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_NcolumnDtop
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_onecolumnbottom
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_twocolumnbottom
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_Ncolumnbottom
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_onecolumnSbottom
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_twocolumnSbottom
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_NcolumnSbottom
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_onecolumnDbottom
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_twocolumnDbottom
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_NcolumnDbottom
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_NcolumnDtopinarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_NcolumnStopinarea
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_makebackgroundframe
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   ($keyval,$pat) = &get_next_optional_argument;

   $_
}

sub do_cmd_vtwotone
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_vtwotonetop
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_vtwotonebottom
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_htwotone
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_htwotoneleft
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_htwotoneright
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_hNtone{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   $keyval,$pat = &get_next_optional_argument;

   local($n);

   $n = &missing_braces
          unless(s/$next_pair_pr_rx/$n=$2;''/eo);

   for ($idx = 1; $idx <= $n; $idx++)
   {
      s/$next_pair_pr_rx/;''/eo;
      s/$next_pair_pr_rx/;''/eo;
      s/$next_pair_pr_rx/;''/eo;
   }

   $_;
}

sub do_cmd_hNtoneleft{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   $keyval,$pat = &get_next_optional_argument;

   local($n);

   $n = &missing_braces
          unless(s/$next_pair_pr_rx/$n=$2;''/eo);

   for ($idx = 1; $idx <= $n; $idx++)
   {
      s/$next_pair_pr_rx/;''/eo;
      s/$next_pair_pr_rx/;''/eo;
      s/$next_pair_pr_rx/;''/eo;
   }

   $_;
}

sub do_cmd_hNtoneright{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   $keyval,$pat = &get_next_optional_argument;

   local($n);

   $n = &missing_braces
          unless(s/$next_pair_pr_rx/$n=$2;''/eo);

   for ($idx = 1; $idx <= $n; $idx++)
   {
      s/$next_pair_pr_rx/;''/eo;
      s/$next_pair_pr_rx/;''/eo;
      s/$next_pair_pr_rx/;''/eo;
   }

   $_;
}

sub do_cmd_vNtone{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   $keyval,$pat = &get_next_optional_argument;

   local($n);

   $n = &missing_braces
          unless(s/$next_pair_pr_rx/$n=$2;''/eo);

   for ($idx = 1; $idx <= $n; $idx++)
   {
      s/$next_pair_pr_rx/;''/eo;
      s/$next_pair_pr_rx/;''/eo;
      s/$next_pair_pr_rx/;''/eo;
   }

   $_;
}

sub do_cmd_vNtonetop{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   $keyval,$pat = &get_next_optional_argument;

   local($n);

   $n = &missing_braces
          unless(s/$next_pair_pr_rx/$n=$2;''/eo);

   for ($idx = 1; $idx <= $n; $idx++)
   {
      s/$next_pair_pr_rx/;''/eo;
      s/$next_pair_pr_rx/;''/eo;
      s/$next_pair_pr_rx/;''/eo;
   }

   $_;
}

sub do_cmd_vNtonebottom{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   $keyval,$pat = &get_next_optional_argument;

   local($n);

   $n = &missing_braces
          unless(s/$next_pair_pr_rx/$n=$2;''/eo);

   for ($idx = 1; $idx <= $n; $idx++)
   {
      s/$next_pair_pr_rx/;''/eo;
      s/$next_pair_pr_rx/;''/eo;
      s/$next_pair_pr_rx/;''/eo;
   }

   $_;
}

sub do_cmd_inserthrule{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;
   ($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_insertvrule{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;
   ($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_newflowframe
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   ($keyval,$pat) = &get_next_optional_argument;

   $_
}

sub do_cmd_newflowframestar
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   ($keyval,$pat) = &get_next_optional_argument;

   $_
}

sub do_cmd_newstaticframe
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   ($keyval,$pat) = &get_next_optional_argument;

   $_
}

sub do_cmd_newstaticframestar
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   ($keyval,$pat) = &get_next_optional_argument;

   $_
}

sub do_cmd_newdynamicframe
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   ($keyval,$pat) = &get_next_optional_argument;

   $_
}

sub do_cmd_newdynamicframestar
{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   ($keyval,$pat) = &get_next_optional_argument;

   $_
}

sub do_cmd_setflowframe
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_setflowframestar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_setstaticframe
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_setstaticframestar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_setdynamicframe
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_setdynamicframestar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_setalldynamicframes
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_setallflowframes
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_setallstaticframes
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_setthumbtab
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_setthumbtabindex
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_ffswapoddeven
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_ffswapoddevenstar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_dfswapoddeven
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_dfswapoddevenstar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_sfswapoddeven
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_sfswapoddevenstar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_dfchaphead
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_dfchapheadstar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_computeleftedgeodd
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_computeleftedgeeven
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_computerightedgeodd
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_computerightedgeeven
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_computebottomedge
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_computetopedge
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_appenddfminitoc
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_appenddfminitocstar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_makethumbtabs
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_setstaticcontents
{
   local($_) = @_;
   local($text);

   s/$next_pair_pr_rx/;''/eo;

   $text = &missing_braces
      unless (s/$next_pair_pr_rx/$text=$2;''/eo);

   $text = "" unless($showstaticcontents);

   "$text$_"
}

sub do_cmd_setstaticcontentsstar
{
   local($_) = @_;
   local($text);

   s/$next_pair_pr_rx/;''/eo;

   $text = &missing_braces
      unless (s/$next_pair_pr_rx/$text=$2;''/eo);

   $text = "" unless($showstaticcontents);

   "$text$_"
}

sub do_cmd_setdynamiccontents
{
   local($_) = @_;
   local($text);

   s/$next_pair_pr_rx/;''/eo;

   $text = &missing_braces
      unless (s/$next_pair_pr_rx/$text=$2;''/eo);

   $text = "" unless($showdynamiccontents);

   "$text$_"
}

sub do_cmd_setdynamiccontentsstar
{
   local($_) = @_;
   local($text);

   s/$next_pair_pr_rx/;''/eo;

   $text = &missing_braces
      unless (s/$next_pair_pr_rx/$text=$2;''/eo);

   $text = "" unless($showdynamiccontents);

   "$text$_"
}

sub do_cmd_appenddynamiccontents
{
   local($_) = @_;
   local($text);

   s/$next_pair_pr_rx/;''/eo;

   $text = &missing_braces
      unless (s/$next_pair_pr_rx/$text=$2;''/eo);

   $text = "" unless($showdynamiccontents);

   "$text$_"
}

sub do_cmd_appenddynamiccontentsstar
{
   local($_) = @_;
   local($text);

   s/$next_pair_pr_rx/;''/eo;

   $text = &missing_braces
      unless (s/$next_pair_pr_rx/$text=$2;''/eo);

   $text = "" unless($showdynamiccontents);

   "$text$_"
}

sub do_env_staticcontents{
   local($_) = @_;
   local($id);

   $id = &missing_braces
              unless (s/$next_pair_rx/$id=$2,''/eo);

   local($body) = ($showstaticcontents ? $_ : "");

   $body
}

sub do_env_staticcontentsstar{
   local($_) = @_;
   local($id);

   $id = &missing_braces
              unless (s/$next_pair_rx/$id=$2,''/eo);

   local($body) = ($showstaticcontents ? $_ : "");

   $body
}

sub do_env_dynamiccontents{
   local($_) = @_;
   local($id);

   $id = &missing_braces
              unless (s/$next_pair_rx/$id=$2,''/eo);

   local($body) = ($showdynamiccontents ? $_ : "");

   $body
}

sub do_env_dynamiccontentsstar{
   local($_) = @_;
   local($id);

   $id = &missing_braces
              unless (s/$next_pair_rx/$id=$2,''/eo);

   local($body) = ($showdynamiccontents ? $_ : "");

   $body
}

sub do_continueonframe{
   local($_) = @_;

   local($keyval,$pat) = &get_next_optional_argument;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_getflowid
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_getstaticid
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_getdynamicid
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_getdynamiclabel
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_getflowlabel
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_getstaticlabel
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_getdynamicbounds
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_getdynamicboundsstar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_getflowbounds
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_getflowboundsstar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_getstaticbounds
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_getstaticboundsstar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_FFaboveleft{ "above left".$_[0] }
sub do_cmd_FFaboveright{ "above right".$_[0] }
sub do_cmd_FFbelowleft{ "below left".$_[0] }
sub do_cmd_FFbelowright{ "below right".$_[0] }
sub do_cmd_FFleft{ "on the left".$_[0] }
sub do_cmd_FFright{ "on the right".$_[0] }
sub do_cmd_FFabove{ "above".$_[0] }
sub do_cmd_FFbelow{ "below".$_[0] }
sub do_cmd_FFoverlap{ "overlap".$_[0] }

sub do_cmd_ffcontinuedtextfont{
   local($_) = @_;
   local($text);

   $text = &missingbraces
      unless (s/$next_pair_pr_rx/$text=$2;''/eo);

   "<EM>$text</EM>$_"
}

sub do_cmd_ffhrule{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_ffvrule{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_labelflow{ &do_cmd_label(@_) }

sub do_cmd_labelflowid{ &do_cmd_label(@_) }

sub do_cmd_minitocstyle{
   local($_) = @_;
   local($text);

   $text = &missing_braces
      unless(s/$next_pair_pr_rx/$text=$2;''/eo);

   "$text$_"
}

sub do_cmd_relativeframelocation
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_relativeframelocationstar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_reldynamicloc
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_reldynamiclocstar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_relflowloc
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_relflowlocstar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_relstaticloc
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_relstaticlocstar
{
   local($_) = @_;

   s/$next_pair_pr_rx/;''/eo;
   s/$next_pair_pr_rx/;''/eo;

   $_
}

sub do_cmd_simpar{
   local($_) = @_;

   "<P>$_"
}

sub do_env_staticfigure{ &do_env_figure(@_) }
sub do_env_statictable{ &do_env_table(@_) }

&ignore_commands( <<_IGNORED_CMDS);
thumbtabindex
tocandthumbtabindex
enablethumbtabs
disablethumbtabs
enableminitoc
makedfheaderfooter
ffcontinuedtextlayout
fflabelfont
ffruledeclarations
ffvadjustfalse
ffvadjusttrue
flowframeshowlayout
finishthispage
framebreak
setffdraftcolor
setffdraftypeblockcolor
showframebboxfalse
showframebboxtrue
showmarginsfalse
showmarginstrue
showtypeblockfalse
showtypeblocktrue
thumbtabformat
thumbtabindexformat
_IGNORED_CMDS

1;
