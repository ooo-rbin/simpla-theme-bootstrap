{if $keyword}{$meta_title="Поиск" scope=parent}{$meta_robots="noindex, nofollow, noarchive" scope=parent}{/if}
{if $smarty.get.features || $smarty.get.sort || $smarty.get.from || $smarty.get.to}{$meta_robots="noindex, nofollow, noarchive" scope=parent}{/if}
{if !$category->path && !$filter}{$meta_title="Новинки" scope=parent}{/if}
{if $filter|default:false=='featured'}{$meta_title="Лидеры продаж" scope=parent}{/if}
{if $filter|default:false=='discounted'}{$meta_title="Спецпредложения" scope=parent}{/if}
<nav>
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		{if !$category->path && !$filter}
			<li class="active">Каталог</li>
		{else}
			<li><a href="/catalog">Каталог</a></li>
		{/if}
		{if $filter|default:false=='featured'}
			<li class="active">Лидеры продаж</li>
		{elseif $filter|default:false=='discounted'}
			<li class="active">Спецпредложения</li>
		{elseif $category}
			{foreach name=cat from=$category->path item=cat}
				{if $smarty.foreach.cat.last && !$brand}
					<li class="active">{$cat->name|escape}</li>
				{else}
					<li><a href="/catalog/{$cat->url}">{$cat->name|escape}</a></li>
				{/if}
			{/foreach}  
			{if $brand}
				<li class="active">{$brand->name|escape}</li>
			{/if}
		{elseif $brand}
			<li class="active">{$brand->name|escape}</li>
		{elseif $keyword}
			<li class="active">Поиск</li>
		{/if}
	</ol>
</nav>
{if !$category->path && !$filter}
	<h1>Все товары</h1>
{elseif $filter|default:false=='featured'}
	<h1>Лидеры продаж</h1>
{elseif $filter|default:false=='discounted'}
	<h1>Спецпредложения</h1>
{elseif $keyword}
	<h1>{$keyword|escape} <small>в поиске</small></h1>
{elseif $page}
	<h1>{$page->name|escape}</h1>
{elseif $brand}
	<h1>{$brand->name|escape} <small>{$category->name|escape}</small></h1>
{else}
	<h1>{$category->name|escape}</h1>
{/if}
{$page->body}
{if $current_page_num==1}{$category->description}{/if}
{if $current_page_num==1}{$brand->description}{/if}
{if $category->brands || ($products && $products|count>1) || $costs.use || $features}
	<form method="get" id="filters" class="form-inline well">
		{if $category->brands}
			<div class="form-group">
				<label class="sr-only" for="filter_brand">Бренды</label>
				<div class="input-group dropdown">
					<button{if $brand->id|default:false} data-brand="{$brand->id}"{/if} id="filter_brand" class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
						{if !$brand->id|default:false}
							Все производители
						{else}
							{if $brand->image|default:false}
								<img class="img" src="{$config->brands_images_dir}{$brand->image}" alt="{$brand->name|escape}">
							{else}
								{$brand->name|escape}
							{/if}
						{/if}
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						{if $brand->id|default:false}
							<li><a rel="nofollow" href="/catalog/{$category->url}">Все производители</a></li>
						{/if}
						{foreach $category->brands as $b}{if $brand->id|default:false!=$b->id}
							<li><a data-brand="{$b->id}" rel="nofollow" href="/catalog/{$category->url}/{$b->url}">
								{if $brand->image}
									<img class="img" src="{$config->brands_images_dir}{$brand->image}" alt="{$b->name|escape}">
								{else}
									{$b->name|escape}
								{/if}
							</a></li>
						{/if}{/foreach}
					</ul>
				</div>
			</div>
		{/if}
		{if $products && $products|count>1}
			<div class="form-group">
				<label class="sr-only" for="filter_sort">Сортировка</label>
				<div class="input-group dropdown">
					<button id="filter_sort" class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
						{if $sort|default:'position'=='position'}
							Без сортировки
							<input type="hidden" name="sort" value="position">
						{elseif $sort|default:'position'=='price'}
							По цене
							<input type="hidden" name="sort" value="price">
						{elseif $sort|default:'position'=='name'}
							По названию
							<input type="hidden" name="sort" value="name">
						{/if}
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						{if $sort|default:'position'!='position'}
							<li><a rel="nofollow" href="{url sort=position page=null}">Без сортировки</a></li>
						{/if}
						{if $sort|default:'position'!='price'}
							<li><a rel="nofollow" href="{url sort=price page=null}">По цене</a></li>
						{/if}
						{if $sort|default:'position'!='name'}
							<li><a rel="nofollow" href="{url sort=name page=null}">По названию</a></li>
						{/if}
					</ul>
				</div>
			</div>
		{/if}
		{if $costs.use}
			<div class="form-group">
				<label for="filter_cost">Цена</label>
				<div class="input-group sliders" id="filter_cost" data-from-field="#filter_cost_from" data-from="{$costs.from}" data-to-field="#filter_cost_to" data-to="{$costs.to}" data-min="{$costs.min}" data-max="{$costs.max}"></div>
				<div class="input-group sliders-hint sliders-from" id="filter_cost_from">
					<span class="input-group-addon">От</span>
					<input name="from" class="form-control" type="number" value="{$costs.from}" min="{$costs.min}" max="{$costs.max}" step="1" data-prefix="От" data-sufix="{$currency->sign}">
					<span class="input-group-addon">{$currency->sign}</span>
				</div>
				<div class="input-group sliders-hint sliders-to" id="filter_cost_to">
					<span class="input-group-addon">До</span>
					<input name="to" class="form-control" type="number" value="{$costs.to}" min="{$costs.min}" max="{$costs.max}" step="1" data-prefix="До" data-sufix="{$currency->sign}">
					<span class="input-group-addon">{$currency->sign}</span>
				</div>
				<div class="input-group sliders-hint btn-toolbar">
					<div class="btn-group">
						<button type="reset" class="btn btn-default">Сбросить</button>
						<button type="submit"class="btn btn-default">Перименить</button>
					</div>
				</div>
			</div>
		{/if}
		{if $features}
			<div class="form-group">
					<div class="btn-toolbar">
						{if $features}
							<div class="btn-group">
								<label for="filter_features" class="form-control btn btn-default toggle{if $smarty.get.features|default:false=='togle'} up active{/if}" data-toggle-class="up active">Расширенный фильтр</label>
							</div>
						{/if}
					</div>
			</div>
			<div class="clearfix"></div>
			<div id="filter_features" class="togglet table-responsive{if $smarty.get.features|default:false=='togle'} up{/if}">
				<table id="purchases" class="table table-striped">
					<tbody>
						{foreach $features as $key=>$f}
							<tr>
								<td class="text-right"><span data-feature="{$f->id}">{$f->name}:</span></td>
								<td class="feature_values" width="100%">
									<a href="{url params=[$f->id=>null, page=>null]}&features=togle" class="btn btn-default{if !$smarty.get.$key} active{/if}">Все</a>
									{foreach $f->options as $o}
										<a href="{url params=[$f->id=>$o->value, page=>null]}&features=togle" class="btn btn-default{if $smarty.get.$key == $o->value} active{/if}">{$o->value|escape}</a>
									{/foreach}
								</td>
							</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
		{/if}
	</form>
{/if}
{if $products && $products|count>0}
	{include file='pagination.tpl'}
	<ul class="row list-unstyled product-map">{foreach from=$products item='product'}{if ($product@iteration-1)%3==0}<div class="clearfix"></div>{/if}
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
	{include file='pagination.tpl'}		
{else}
	<p>Товары не найдены</p>
{/if}
