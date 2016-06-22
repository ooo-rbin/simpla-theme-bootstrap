/**
 * Сценарий темы
 * @require script.coffee.js
 */
(function ($) {
	$(function($) {
		var w = $(window);
		// Кнопки поделиться
		(function() {
			if (window.pluso) {
				if (typeof window.pluso.start == "function") {
					return;
				}
			}
			if (window.ifpluso == undefined) {
				window.ifpluso = 1;
				var d = document;
				var s = d.createElement('script');
				var g = 'getElementsByTagName';
				s.type = 'text/javascript';
				s.charset = 'UTF-8';
				s.async = true;
				s.src = ('https:' == window.location.protocol ? 'https' : 'http')  + '://share.pluso.ru/pluso-like.js';
				var h = d[g]('body')[0];
				h.appendChild(s);
			}
		})();
		// Слайдер
		if (w.innerWidth() >= 768) {
			setTimeout(function () {
				var carousel_h = 0;
				$('#slider .carousel-inner>.item').each(function () {
					carousel_h = Math.max(carousel_h, $(this).outerHeight());
				}).css({'height': Math.floor(carousel_h).toString() + 'px'});
				$('#slider').addClass('carousel').carousel();
			}, 500);
		}
		// Галереи
		$('*[data-toggle="lightbox"]').click(function (event) {
			event.preventDefault();
			$(this).ekkoLightbox();
		});
		// Слайдер выбора цены
		$('#filter_cost').each(function () {
			var $self = $(this);
			var self = this;
			noUiSlider.create(this, {
				start: [
					$self.data('from'),
					$self.data('to')
				],
				connect: false,
				margin: 1,
				step: 1,
				animate: true,
				range: {
					'min': $self.data('min'),
					'max': $self.data('max')
				}
			});
			var form = $('#filters');
			var timeout = false;
			var timeout_set = function () {
				if (timeout) {
					clearTimeout(timeout);
				}
				timeout = setTimeout(function () {
					form.submit();
				}, 2000);
			};
			var from_field = $($self.data('from-field'));
			var from = from_field.find('input').change(function () {
				self.noUiSlider.set([$(this).val(), null]);
				timeout_set();
			});
			var to_field = $($self.data('to-field'));
			var to = to_field.find('input').change(function () {
				self.noUiSlider.set([null, $(this).val()]);
				timeout_set();
			});
			var field_set = [
				from,
				to
			];
			var handles = $self.find('.noUi-handle').each(function (index) {
				if (field_set[index]) {
					this.field = field_set[index];
				}
			}).hover(
				function () {
					$(this).tooltip('destroy');
					$(this).tooltip({
						'animation': false,
						'container': 'body',
						'placement': 'bottom',
						'trigger': 'manual',
						'title': this.field.data('prefix') + ' ' + this.field.val() + ' ' + this.field.data('sufix')
					}).tooltip('show').addClass('up');
				},
				function () {
					var self = $(this);
					setTimeout(function () {
						if (!self.hasClass('drag')) {
							self.tooltip('hide');
							self.removeClass('up');
						}
					}, 1000);
				}
			).mousedown(function () {
				var self = $(this);
				self.addClass('drag');
				$(document).mouseup(function () {
					self.removeClass('drag');
					self.mouseleave();
				});
			});
			self.noUiSlider.on('update', function (values, handle) {
				var old_values = [
					from.val(),
					to.val()
				];
				from.val(parseInt(values[0]));
				to.val(parseInt(values[1]));
				handles.each(function () {
					var self = $(this);
					if (self.hasClass('up')) {
						self.mouseenter();
					}
				});
				$.each(old_values, function (index, value) {
					if (values[index] && parseInt(values[index]) !== parseInt(value)) {
						timeout_set();
					}
				});
			});
		});
		// Переключатель
		$('.toggle').click(function (event) {
			event.preventDefault();
			var self = $(this);
			var target = $('#' + self.attr('for'));
			var value = target.attr('data-value');
			target.attr('data-value', target.val());
			if (value) target.val(value);
			self.toggleClass((self.data('toggle-class')) ? self.data('toggle-class') : 'up');
			target.toggleClass((self.data('togglet-class')) ? self.data('togglet-class') : 'up');
			return false;
		});
		// Вкунтакт
		setTimeout(function () {
			VK.Widgets.Group('vk_groups', {
				mode: 0,
				width: Math.floor($('#catalog').outerWidth()).toString(),
				height: '300',
				color1: 'FFFFFF',
				color2: '2B587A',
				color3: '5B7FA6'
			}, 55104130);
		}, 500);
		// Ввод купона
		$('#coupon_code').keypress(function(event) {
			if(13 == event.keyCode) {
				$('#deliveries_name').attr('data-format', '');
				$('#deliveries_email').attr('data-format', '');
				document.cart.submit();
			}
		});
		// Плавающее меню
		(function () {
			var float = $('#float');
			var nav = $('#nav');
			var top = float.offset().top;
			var height = float.height().toString() + 'px';
			w.scroll(function (event) {
				if (w.scrollTop() > top) {
					nav.css({'height': height});
					float.addClass('fly');
				} else {
					nav.css({'height': 'auto'});
					float.removeClass('fly');
				}
			});
			w.scroll();
		})();
		// Аяксовая корзина
		(function () {
			var timeout = false;
			var informer = $('#cart_informer');
			$('.product form').on('submit', function(event) {
				event.preventDefault();
				var self = $(this);
				if (!this.selected) {
					this.selected = self.find('button').first();
				}
				var variant = $(this.selected);
				var data = {};
				data[variant.attr('name')] = variant.val();
				$.ajax({
					'url': self.data('ajax-url'),
					'data': data,
					'dataType': 'json',
					'success': function(data) {
						informer.html(data);
						if (variant.data('result-text')) {
							variant.text(variant.data('result-text'));
						}
						var popover = $('#popower').popover({
							content: '<p>Вы можете перейти в <a href="/cart/" title="Закончить покупки">корзину</a>, для завершения оформления заказа.</p>',
							html: true,
							placement: 'bottom',
							title: 'Добавлено в корзину',
							trigger: 'focus'
						}).popover('show');
						popover.parent().hover(
							function () {
								if (timeout) {
									clearTimeout(timeout);
									timeout = false;
								}
							},
							function () {
								if (!timeout) {
									timeout = setTimeout(function () {
										popover.popover('hide');
									}, 1000);
								}
							}
						);
						if (timeout) {
							clearTimeout(timeout);
							timeout = false;
						}
						timeout = setTimeout(function () {
							popover.popover('hide');
						}, 10000);
					}
				});
				var o1 = self.offset();
				var o2 = informer.offset();
				var dx = o1.left - o2.left;
				var dy = o1.top - o2.top;
				var distance = Math.sqrt(dx * dx + dy * dy);
				var img = self.parent('.thumb').find('.img');
				img.effect('transfer', {
					'to': informer,
					'className': 'transfer_class'
				}, distance);
				var transfer = $('.transfer_class');
				transfer.append(img.clone()).find('.img').css({height: '100%'});
				return false;
			}).each(function () {
				var self = this;
				self.variant = null;
				$(self).find('button').click(function () {
					self.selected = this;
				});
			});
		})();
		//  Автозаполнитель поиска.
		(function () {
			var search = $('#search');
			search.autocomplete({
				serviceUrl: '/ajax/search_products.php',
				dataType: 'json',
				minChars: 1,
				onSelect: function () {
					search.closest('form').submit();
				},
				formatResult: function (suggestion, currentValue) {
					var title = suggestion.value.replace(new RegExp('(' + currentValue.replace(new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g'), '\\$1') + ')', 'gi'), '<strong>$1<\/strong>');
					return (suggestion.data.image ? '<img align="absmiddle" src="' + suggestion.data.image + '"> ' : '') + title;
				},
				beforeRender: function (container) {
					container.addClass('list-group').attr('id', 'autocomplete');
					var suggestion = [];
					container.find('.autocomplete-suggestion').each(function () {
						if (suggestion.length > 5) {
							return;
						}
						var self = $(this);
						suggestion.push($('<button>')
							.attr('class', self.attr('class') + ' list-group-item')
							.attr('data-index', self.attr('data-index'))
							.html(self.html())
						);
					}).remove();
					return container.append(suggestion);
				}
			});
		})();
		// Навигация по соседним товарам
		$(document).on('keydown', function (event) {
			if (event.ctrlKey) {
				var href = false;
				switch (event.keyCode ? event.keyCode : event.which ? event.which : null) {
					case 0x25:
						href = $('#prev_page_link').attr('href');
						break;
					case 0x27:
						href = $('#next_page_link').attr('href');
						break;
				}
				if (href) {
					document.location = href;
				}
			}
		});
	});
})(jQuery);