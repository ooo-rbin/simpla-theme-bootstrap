<!DOCTYPE html>
<html lang="ru-RU">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="{$meta_description|escape}">
		<meta name="keywords" content="{$meta_keywords|escape}">
		{if $meta_robots|default:false}<meta name="robots" content="{$meta_robots|escape}">{/if}
		<title>{$meta_title|escape}</title>
		<base href="{$config->root_url}">
		<link href="/favicon.png" rel="apple-touch-icon">
		<link href="/favicon.png" rel="icon">
		<link href="/favicon.ico" rel="shortcut icon">
		<!--[if lt IE 9]>
			<script src="/design/{$settings->theme|escape}/js/lib/html5shiv.min.js"></script>
			<script src="/design/{$settings->theme|escape}/js/lib/respond.min.js"></script>
		<![endif]-->
		<link href="/design/{$settings->theme|escape}/css/lib/nouislider.min.css" rel="stylesheet">
		<link href="/design/{$settings->theme|escape}/css/theme.min.css" rel="stylesheet">
	</head>
	<body>
		<header id="header">
			<div class="container">
				<div class="row">
					<figure id="logo" class="col-xs-12 col-sm-12 col-md-6">
						<figcaption>Интернет магазин</figcaption>
						<img src="/design/{$settings->theme}/images/logo.png" alt="{$settings->company_name|escape}">
					</figure>
					<div class="clearfix visible-xs-block visible-sm-block"></div>
					<div class="col-xs-12 col-sm-12 col-md-6" id="inform">
						<address>
							<b class="hidden visible-print-inline">Телефоны:</b> <a href="tel:83422020365">+7 (342) <span>20-20-365</span></a><br>
							<b class="hidden visible-print-inline">E-mail:</b> <a href="mailto:{$settings->notify_from_email|escape}">{$settings->notify_from_email|escape}</a><br>
							<b class="hidden visible-print-inline">Адресс:</b> г. Пермь, ул. Куйбышева 47<br>
						</address>
						<p class="hidden-print" id="cart">
							<a href="/cart/" rel="nofollow" title="Открыть корзину"><b>Корзина:</b></a><span class="br hidden-print"></span>
							<span id="cart_informer">
								{include file='cart_informer.tpl'}
							</span>
						</p>
					</div>
				</div>
			</div>
		</header>
		<nav id="nav" class="hidden-print navbar">
			<div id="float">
				<div class="container">
					<div><div id="popower"></div></div>
					<form action="/products" class="navbar-right navbar-brand" role="search">
						<p class="input-group">
							<label for="search" class="sr-only">Поиск товара: </label>
							<input id="search" class="form-control" type="text" name="keyword" value="{$keyword|escape}" placeholder="Поиск товара"/>
							<span class="input-group-btn">
								<button class="btn btn-default" type="submit">
									<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
									<span class="sr-only">Найти</span>
								</button>
							</span>
						</p>
					</form>
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#menu" aria-expanded="false">
						<span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span>
						<span class="sr-only">Меню</span>
					</button>
					<div class="collapse navbar-collapse navbar-left" id="menu">
						<ul class="nav navbar-nav">
							{foreach $pages as $p}
								{if $p->menu_id == 1}
									<li{if $page && $page->id == $p->id} class="active"{/if}>
										<a data-page="{$p->id}" href="{$p->url}">{$p->name|escape}</a>
									</li>
								{/if}
							{/foreach}
							{if $user}<li class="dropdown">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">{$user->name} <span class="caret"></span></a>
									<ul class="dropdown-menu">
										<li><a href="/user" rel="nofollow">Заказы</a></li>
										{if $group->discount>0}<li class="dropdown-header">Ваша скидка &mdash; {$group->discount}%</li>{/if}
										<li role="separator" class="divider"></li>
										<li><a href="/user/logout" rel="nofollow">Выйти</a></li>
									</ul>
							</li>{else}<li><a href="/user/login" rel="nofollow">Вход</a></li>{/if}
						</ul>
					</div>
				</div>
			</div>
		</nav>
		<section id="section">
			<div class="container">
				<div class="row">
					<main class="col-xs-12 col-md-9 col-md-push-3">
						{$content}
					</main>
					<asside class="col-xs-12 col-md-3 col-md-pull-9">
						<nav id="catalog">
							{function name=category_active}{if $category->id == $active} class="{$class}"{elseif $category->subcategories}{foreach $category->subcategories as $subcategory}{if $subcategory->visible}{category_active category=$subcategory active=$active class=$class}{/if}{/foreach}{/if}{/function}
							{function name=categories_tree}
								<ul class="dropdown-menu menu-down">
									{foreach $categories as $category}{if $category->visible}
										<li{if $category->id == $active} class="active"{/if}>
											<div><a href="/catalog/{$category->url}" data-category="{$category->id}">{$category->name|escape}</a></div>
											{if $category->subcategories}{categories_tree categories=$category->subcategories active=$active}{/if}
										</li>
									{/if}{/foreach}
								</ul>
							{/function}
							<ul class="nav nav-pills nav-stacked">
								{foreach $categories as $c}{if $c->visible}{if $c->subcategories}
									<li{category_active category=$c active=$category->id class='open active'}>
										<div><a href="/catalog/{$c->url}" data-category="{$c->id}" class="btn menu-top"><span class="icon"{if $c->image} style="background-image: url({$config->categories_images_dir}{$c->image});"{/if}></span><span>{$c->name|escape}</span><span class="caret glyphicon"></span>
										</a></div>
										{categories_tree categories=$c->subcategories active=$category->id}
									</li>
								{else}
									<li{category_active category=$c active=$category->id class='active'}>
										<div><a href="/catalog/{$c->url}" data-category="{$c->id}" class="btn menu-top"><span class="icon"{if $c->image} style="background-image: url({$config->categories_images_dir}{$c->image});"{/if}></span><span>{$c->name|escape}</span></a></div>
									</li>
								{/if}{/if}{/foreach}
							</ul>
							<div id="vk_groups"></div>
							<form enctype="multipart/form-data" action="/design/{$settings->theme}/mailer.php" method="post" id="mailer" class="form tomove">
								<h3>Заказать звонок</h3>
								{if $smarty.session.phonerequest_result && $smarty.session.phonerequest_result.valid>$smarty.now}<div class="well">
									{$smarty.session.phonerequest_result.message}{assign var='mailer_name' value="{$smarty.session.phonerequest_result.name}"}{assign var='mailer_phone' value="{$smarty.session.phonerequest_result.phone}"}
								</div>{/if}
								<div class="form-group">
									<label for="phonerequest_name" class="sr-only">Имя</label>
									<div class="input-group">
										<span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></span>
										<input placeholder="Имя" type="text" class="form-control" id="phonerequest_name" name="name" required pattern="^[А-Яа-яЁё\s]+$" maxlength="32" value="{$mailer_name|escape}">
									</div>
								</div>
								<div class="form-group">
									<label for="phonerequest_phone" class="sr-only">Телефон</label>
									<div class="input-group">
										<span class="input-group-addon"><span class="glyphicon glyphicon-phone" aria-hidden="true"></span></span>
										<input placeholder="Телефон" type="text" class="form-control" id="phonerequest_phone" name="phone" required pattern="^[\d\s\+\-\(\)]+$" maxlength="32" value="{$mailer_phone|escape}">
									</div>
								</div>
								{if $smarty.session.mailer_signature}{assign var='mailer_sign' value="{$config->root_url}{$smarty.server.REQUEST_URI}{$smarty.session.mailer_signature}"}{else}{assign var='mailer_sign' value="{$config->root_url}{$smarty.server.REQUEST_URI}{$smarty.cookies.PHPSESSID}"}{/if}<input type="hidden" name="sign" value="{$mailer_sign|md5}">
								<button type="submit" class="btn btn-default">Заказать звонок</button>
							</form>
						</nav>
					</asside>
				</div>
			</div>
		</section>
		<footer id="footer">
			<div class="container">
				<p class="pull-left"><span class="glyphicon glyphicon-copyright-mark" aria-hidden="true"></span> {$settings->company_name|escape}, {$smarty.now|date_format:'%Y'}<br>
				Все права защищены</p>
				<p class="pull-right"><a id="creator" href="http://rbin.ru/" target="_blank" title="Создание и продвижение сайтов">ООО «Бизнес Интеллект»</a></p>
			</div>
		</footer>
		<script defer src="/design/{$settings->theme}/js/lib/jquery.min.js"></script>
		<script defer src="/design/{$settings->theme}/js/lib/jquery-ui.min.js"></script>
		<script defer src="/design/{$settings->theme}/js/lib/jquery-autocomplete.min.js"></script>
		<script defer src="/design/{$settings->theme}/js/lib/bootstrap.min.js"></script>
		<script defer src="/design/{$settings->theme}/js/lib/nouislider.min.js"></script>
		<script defer src="/design/{$settings->theme}/js/lib/ekko-lightbox.min.js"></script>
		<script defer src="/design/{$settings->theme}/js/lib/pluso-like.js"></script>
		<script defer src="/design/{$settings->theme}/js/lib/openapi.js"></script>
		<script defer src="/design/{$settings->theme}/js/script.min.js"></script>
		{if $smarty.session.admin == 'admin'}<script defer src ="/design/{$settings->theme}/js/admin.min.js"></script>{/if}
	</body>
</html>
