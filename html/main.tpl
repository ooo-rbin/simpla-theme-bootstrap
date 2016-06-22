<h1 class="sr-only">{$page->header}</h1>
{assign var='action' value="/design/{$settings->theme|escape}/cart.php"}{assign var='body' value='<!--more-->'|explode:$page->body}{$body.0|replace:'[action]':$action}<div class="clearfix"></div>
{get_new_products var=new_products limit=3}{if $new_products}
	<h2 class="hr">Новинки</h2>
	<ul class="row list-unstyled product-map">{foreach $new_products as $product}
		<li class="product col-sm-4"><div class="thumbnail thumb">
			<a href="/products/{$product->url}" rel="nofollow">
				{if $product->image}
					<img class="img" src="{$product->image->filename|resize:220:220}" alt="{$product->name|escape}"/>
				{else}
					<img class="img" src="/design/{$settings->theme|escape}/images/foto.png" alt="Фото скоро будет"/>
				{/if}
			</a>
			<form class="caption" action="/cart" data-ajax-url="/design/{$settings->theme|escape}/cart.php">
				<h3 class="product-title"><a data-product="{$product->id}" href="/products/{$product->url}" title="Подробнее о товаре {$product->name|escape}">{$product->name|escape}</a></h3>
				{if $product->variants|count>0}{foreach $product->variants as $v}
					{if $v->name}<label for="new_{$v->id}" class="control-label">{$v->name}</label>{/if}
					<div class="btn-toolbar"><div class="btn-group">
						<div class="btn-group">
							<label for="new_{$v->id}" class="btn btn-default{if $v->compare_price > 0} btn-sm{/if}">
								{if $v->compare_price > 0}<del><small>{$v->compare_price|convert} <span class="currency">{$currency->sign|escape}</span></small></del><br>{/if}
								<span>{$v->price|convert} <span class="currency">{$currency->sign|escape}</span></span>
							</label>
						</div>
						<div class="btn-group">
							<button id="new_{$v->id}" type="submit" name="variant" value="{$v->id}" class="btn btn-warning{if $v->compare_price > 0} btn-lg{/if}" data-result-text="В корзине"><span class="glyphicon glyphicon-cart-plus" aria-hidden="true"></span></button>
						</div>
					</div></div>
				{/foreach}{else}
					<div class="btn-toolbar"><div class="btn-group">
						<div class="btn-group">
							<label for="new_p{$product->id}" class="btn btn-default btn-sm">
								<span>Нет в наличии</span><br>
								<small>цена уточняется</small>
							</label>
						</div>
						<div class="btn-group">
							<button id="new_p{$product->id}" type="submit" name="product" value="{$product->id}" class="btn btn-warning btn-lg" data-result-text="В корзине">Заказать</button>
						</div>
					</div></div>
				{/if}
			</form>
		</div></li>
	{/foreach}</ul><div class="clearfix"></div>
	<p><a title="Каталог новинок" href="/catalog/">Посмотреть все новинки</a></p>
{/if}{get_featured_products var=featured_products}{if $featured_products}
	<h2 class="hr">Лидеры продаж</h2>
	<ul class="row list-unstyled product-map">{foreach $featured_products as $product}
		<li class="product col-sm-4"><div class="thumbnail thumb">
			<a href="/products/{$product->url}" rel="nofollow">
				{if $product->image}
					<img class="img" src="{$product->image->filename|resize:220:220}" alt="{$product->name|escape}"/>
				{else}
					<img class="img" src="/design/{$settings->theme|escape}/images/foto.png" alt="Фото скоро будет"/>
				{/if}
			</a>
			<form class="caption" action="/cart" data-ajax-url="/design/{$settings->theme|escape}/cart.php">
				<h3 class="product-title"><a data-product="{$product->id}" href="/products/{$product->url}" title="Подробнее о товаре {$product->name|escape}">{$product->name|escape}</a></h3>
				{if $product->variants|count>0}{foreach $product->variants as $v}
					{if $v->name}<label for="featured_{$v->id}" class="control-label">{$v->name}</label>{/if}
					<div class="btn-toolbar"><div class="btn-group">
						<div class="btn-group">
							<label for="featured_{$v->id}" class="btn btn-default{if $v->compare_price > 0} btn-sm{/if}">
								{if $v->compare_price > 0}<del><small>{$v->compare_price|convert} <span class="currency">{$currency->sign|escape}</span></small></del><br>{/if}
								<span>{$v->price|convert} <span class="currency">{$currency->sign|escape}</span></span>
							</label>
						</div>
						<div class="btn-group">
							<button id="featured_{$v->id}" type="submit" name="variant" value="{$v->id}" class="btn btn-warning{if $v->compare_price > 0} btn-lg{/if}" data-result-text="В корзине"><span class="glyphicon glyphicon-cart-plus" aria-hidden="true"></span></button>
						</div>
					</div></div>
				{/foreach}{else}
					<div class="btn-toolbar"><div class="btn-group">
						<div class="btn-group">
							<label for="new_p{$product->id}" class="btn btn-default btn-sm">
								<span>Нет в наличии</span><br>
								<small>цена уточняется</small>
							</label>
						</div>
						<div class="btn-group">
							<button id="new_p{$product->id}" type="submit" name="product" value="{$product->id}" class="btn btn-warning btn-lg" data-result-text="В корзине">Заказать</button>
						</div>
					</div></div>
				{/if}
			</form>
		</div></li>
	{/foreach}</ul><div class="clearfix"></div>
	<p><a title="Каталог лидеров продаж" href="/catalog/hits/">Посмотреть все лидеры продаж</a></p>
{/if}{get_discounted_products var=discounted_products limit=9}{if $discounted_products}
	<h2 class="hr">Спецпредложения</h2>
	<ul class="row list-unstyled product-map">{foreach $discounted_products as $product}
		<li class="product col-sm-4"><div class="thumbnail thumb">
			<a href="/products/{$product->url}" rel="nofollow">
				{if $product->image}
					<img class="img" src="{$product->image->filename|resize:220:220}" alt="{$product->name|escape}"/>
				{else}
					<img class="img" src="/design/{$settings->theme|escape}/images/foto.png" alt="Фото скоро будет"/>
				{/if}
			</a>
			<form class="caption" action="/cart" data-ajax-url="/design/{$settings->theme|escape}/cart.php">
				<h3 class="product-title"><a data-product="{$product->id}" href="/products/{$product->url}" title="Подробнее о товаре {$product->name|escape}">{$product->name|escape}</a></h3>
				{if $product->variants|count>0}{foreach $product->variants as $v}
					{if $v->name}<label for="discounted_{$v->id}" class="control-label">{$v->name}</label>{/if}
					<div class="btn-toolbar"><div class="btn-group">
						<div class="btn-group">
							<label for="discounted_{$v->id}" class="btn btn-default{if $v->compare_price > 0} btn-sm{/if}">
								{if $v->compare_price > 0}<del><small>{$v->compare_price|convert} <span class="currency">{$currency->sign|escape}</span></small></del><br>{/if}
								<span>{$v->price|convert} <span class="currency">{$currency->sign|escape}</span></span>
							</label>
						</div>
						<div class="btn-group">
							<button id="discounted_{$v->id}" type="submit" name="variant" value="{$v->id}" class="btn btn-warning{if $v->compare_price > 0} btn-lg{/if}" data-result-text="В корзине"><span class="glyphicon glyphicon-cart-plus" aria-hidden="true"></span></button>
						</div>
					</div></div>
				{/foreach}{else}
					<div class="btn-toolbar"><div class="btn-group">
						<div class="btn-group">
							<label for="new_p{$product->id}" class="btn btn-default btn-sm">
								<span>Нет в наличии</span><br>
								<small>цена уточняется</small>
							</label>
						</div>
						<div class="btn-group">
							<button id="new_p{$product->id}" type="submit" name="product" value="{$product->id}" class="btn btn-warning btn-lg" data-result-text="В корзине">Заказать</button>
						</div>
					</div></div>
				{/if}
			</form>
		</div></li>
	{/foreach}</ul><div class="clearfix"></div>
	<p><a title="Каталог спецпредложений" href="/catalog/sales/">Посмотреть все спецпредложения</a></p>
{/if}{$body.1|default:''}
<p class="text-right"><span class="text-nowrap">Поделиться в соцсетях</span> <span class="pluso" data-background="#ebebeb" data-options="small,round,line,horizontal,nocounter,theme=04" data-services="vkontakte,odnoklassniki,facebook,twitter,google,moimir,email,print"></span></p>
