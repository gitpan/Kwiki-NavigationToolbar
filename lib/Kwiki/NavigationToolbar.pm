package Kwiki::NavigationToolbar;
use Kwiki::Plugin -Base;
use mixin 'Kwiki::Installer';
our $VERSION = '0.01';
const class_id => 'navigation_toolbar';
const class_title => 'Kwiki Navigation Toolbar';
const navigation_toolbar_template => 'navigation_toolbar_pane.html';
const css_file => 'navigation_toolbar.css';
const config_file => 'navigation_toolbar.yaml';

sub html {
    my $nav = $self->pages->new_page($self->config->navigation_toolbar_page);
    my @navs = split/\n+/,$nav->content;
    my $content = join('|', map { "<a href=\"?$_->{name}\">$_->{display}</a>" }
			   map {
			       my ($name,$display) = split/,/;
			       $display ||= $name;
			       {name => $name, display => $display,}
			   }
		       @navs);
    $self->template->process(
	$self->navigation_toolbar_template,
	navigation_toolbar_content => $content
       );
}

=head1 NAME

Kwiki::Navigation_Toolbar - Navigation Toolbar

=head1 DESCRIPTION

=head1 COPYRIGHT

Copyright 2004 by Kang-min Liu <gugod@gugod.org>.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

See <http://www.perl.com/perl/misc/Artistic.html>

=cut

__DATA__
__css/navigation_toolbar.css__

__template/tt2/navigation_toolbar_pane.html__
<!-- BEGIN navigation_toolbar_pane.html -->
<div class="navigation_toolbar">
[% navigation_toolbar_content %]
</div>
<!-- END navigation_toolbar_pane.html -->
__config/navigation_toolbar.yaml__
navigation_toolbar_page: KwikiNavigationToolbar

