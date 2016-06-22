# Закладка на панель управления
jQuery ($) ->
	$ '<a>'
	.attr 'href', '/simpla/'
	.attr 'class', 'hidden-print'
	.css
		position: 'absolute'
		left: '3%'
		top: '0px'
		width: '12px'
		height: '35px'
		background: 'url(/js/admintooltip/i/bookmark.gif) no-repeat'
	.appendTo 'body'