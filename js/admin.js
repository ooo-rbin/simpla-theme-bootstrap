/**
 * Сценарий администратора
 * @require admin.coffee.js
 */
(function ($) {
	$(function () {
		// Подсказки администратора
		var timeout = new function () {
			var self = this;
			var _obj, _cal, _id;
			self.clear = function (obj, cal) {
				if (obj !== _obj) {
					if (_cal) {
						_cal();
					}
					if (cal instanceof Function) {
						cal();
					}
				}
				if (_id) {
					clearTimeout(_id);
				}
				_obj = false;
				_cal = false;
				_id = false;
			};
			self.setup = function (obj, cal) {
				if (cal instanceof Function) {
					if (_id) {
						self.clear(obj);
					}
					_obj = obj;
					_cal = cal;
					_id = setTimeout(function () {
						self.clear(false);
					}, 1000);
				}
			};
		};

		function tip(prefix, element, callback) {
			element.popover({
				placement: 'bottom',
				trigger: 'manual',
				html: true,
				title: prefix + ' "' + element.text() + '"',
				template: '<div class="popover hidden-print" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>',
				content: function () {
					var container = $('<ul>').attr('class', 'nav nav-pills nav-stacked');
					$.each(callback(element), function () {
						this.appendTo(container);
					});
					return container;
				}
			});
			element.parent().on('mouseenter', function () {
				timeout.clear(this, function () {
					element.popover('show');
				});
			}).on('mouseleave', function () {
				timeout.setup(this, function () {
					element.popover('hide');
					timeout.id = false;
				});
			});
		}

		var from = encodeURIComponent(location);

		function adminurl(components, title, cls) {
			var href = '/simpla/index.php?return=' + from;
			$.each(components, function (key, val) {
				href = href + '&' + encodeURIComponent(key) + '=' + encodeURIComponent(val);
			});
			if (!title || !title.toString()) {
				title = 'Редактировать';
			}
			if (!cls || !cls.toString()) {
				cls = 'pencil';
			}
			return $('<li>').append(
				$('<a>').attr('href', href).attr('title', title).attr('class', 'text-left text-nowrap').append(
					$('<span>').attr('class', 'glyphicon glyphicon-' + cls).attr('aria-hidden', 'true'),
					document.createTextNode(' ' + title)
				)
			);
		}

		$('[data-page]').each(function () {
			tip('Страница', $(this), function (element) {
				return [
					adminurl({
						module: 'PageAdmin',
						id: element.data('page')
					}),
					adminurl({
						module: 'PageAdmin'
					}, 'Добавить страницу', 'plus')
				];
			});
		});
		$('[data-category]').each(function () {
			tip('Категория', $(this), function (element) {
				return [
					adminurl({
						module: 'CategoryAdmin',
						id: element.data('category')
					}),
					adminurl({
						module: 'ProductAdmin',
						category_id: element.data('category')
					}, 'Добавить товар', 'plus')
				];
			});
		});
		$('[data-brand]').each(function () {
			tip('Бренд', $(this), function (element) {
				return [adminurl({
					module: 'BrandAdmin',
					id: element.data('brand')
				})];
			});
		});
		$('[data-product]').each(function () {
			tip('Продукт', $(this), function (element) {
				return [adminurl({
					module: 'ProductAdmin',
					id: element.data('product')
				})];
			});
		});
		$('[data-post]').each(function () {
			tip('Запись', $(this), function (element) {
				return [adminurl({
					module: 'PostAdmin',
					id: element.data('post')
				})];
			});
		});
		$('[data-feature]').each(function () {
			tip('Свойство', $(this), function (element) {
				return [adminurl({
					module: 'FeatureAdmin',
					id: element.data('feature')
				})];
			});
		});
	});
})(jQuery);