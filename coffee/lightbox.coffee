# Галереи
jQuery ($) ->
	$ '*[data-toggle="lightbox"]'
	.click (event) ->
		event.preventDefault();
		do $ this
		.ekkoLightbox
