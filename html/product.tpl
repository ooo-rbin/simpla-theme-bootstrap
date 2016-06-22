<nav>
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		<li><a href="/catalog">Каталог</a></li>
		{foreach $category->path as $cat}
			<li><a href="/catalog/{$cat->url}">{$cat->name|escape}</a></li>
		{/foreach}
		{if $brand}
			<li><a href="/catalog/{$cat->url}/{$brand->url}">{$brand->name|escape}</a></li>
		{/if}
		<li class="active">{$product->name|escape}</li>
	</ol>
</nav>
<h1><span data-product="{$product->id}">{$product->name|escape}</span></h1>
<div class="row">
	<div class="product col-sm-4 col-sm-push-8">
		<div class="thumbnail thumb tomove">
			{if $product->image}<a href="{$product->image->filename|resize:800:600:w}" data-gallery="Галерея товара" data-toggle="lightbox"><img class="img" src="{$product->image->filename|resize:220:220}" alt="{$product->name|escape}"/></a>{/if}
			<form class="caption" action="/cart" data-ajax-url="/design/{$settings->theme|escape}/cart.php">
				<p><span class="text-nowrap">Поделиться в соцсетях</span> <span class="pluso" data-background="#ebebeb" data-options="small,round,line,horizontal,nocounter,theme=04" data-services="vkontakte,odnoklassniki,facebook,twitter,google,moimir,email,print"></span></p>
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
		</div>
		{if $product->images|count>1}
			<div id="gallery" class="row">
				{foreach from=$product->images|cut item='image'}
					{if ($image@iteration-1)%2==0}<div class="clearfix"></div>{/if}
					<div class="col-xs-6"><a data-gallery="Галерея товара" data-toggle="lightbox" href="{$image->filename|resize:800:600:w}" class="thumbnail"><img class="img" src="{$image->filename|resize:110}" alt="{$product->name|escape}" /></a></div>
				{/foreach}
			</div>
		{/if}
		{if $product->features}
			<dl class="dl-horizontal">
				{foreach $product->features as $f}
					<dt>{$f->name}</dt>
					<dd>{$f->value}</dd>
				{/foreach}
			</dl>
		{/if}
	</div>
	<div class="col-sm-8 col-sm-pull-4">
		{$product->body}
		{if $prev_product || $next_product}
			<hr>
			<nav id="nearby">
				<ul class="pager row">
					{if $prev_product}
						<li class="previous col-xs-6"><a title="Ctr + ←" id="prev_page_link" href="/products/{$prev_product->url}"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> {$prev_product->name|escape}</a></li>
					{/if}
					{if $next_product}
						<li class="next col-xs-6{if !$prev_product} col-xs-offset-6{/if}"><a title="Ctr + →" id="next_page_link" href="/products/{$next_product->url}">{$next_product->name|escape} <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span></a></li>
					{/if}
				</ul>
			</nav>
		{/if}
		{if $related_products}
			<hr>
			<h2>Так же советуем посмотреть</h2>
			<ul class="row list-unstyled product-map">{foreach from=$related_products item='product'}{if ($product@iteration-1)%3==0}<div class="clearfix"></div>{/if}
				<li class="product col-sm-4"><div class="thumbnail thumb">
					{if $product->image}<a href="/products/{$product->url}"><img class="img" src="{$product->image->filename|resize:220:220}" alt="{$product->name|escape}"/></a>{/if}
					<form class="caption" action="/cart" data-ajax-url="/design/{$settings->theme|escape}/cart.php">
						<h3 class="product-title"><a data-product="{$product->id}" href="/products/{$product->url}">{$product->name|escape}</a></h3>
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
		{/if}
		<div id="comments" class="panel panel-default">
			<h2 class="panel-heading">Комментарии</h2>
			{if $comments}
				<ul class="list-group">
					{foreach $comments as $comment}
						<li class="list-group-item comment" id="comment_{$comment->id}">
							<h3 class="list-group-item-heading">{$comment->name|escape} <small>{$comment->date|date}, {$comment->date|time}</small>{if !$comment->approved} <span class="badge">Ожидает модерации</span>{/if}</h3>
							<blockquote class="list-group-item-text">{$comment->text|escape|nl2br}</blockquote>
						</li>
					{/foreach}
				</ul>
			{else}
				<p class="panel-body">Пока нет комментариев</p>
			{/if}
			<form id="addcomment" class="form panel-footer" method="post">
				<h3>Написать комментарий</h3>
				{if $error}
					<div class="well"><span class="text-danger">
						<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
						{if $error=='captcha'}Неверно введена капча
						{elseif $error=='empty_name'}Введите имя
						{elseif $error=='empty_comment'}Введите комментарий
						{/if}
					</span></div>
				{/if}
				<div class="form-group{if $error} {if $error=='empty_name'}has-error has-feedback{elseif $error!='captcha'}has-success has-feedback{/if}{/if}">
					<label class="sr-only" for="comment_name">Имя</label>
					<div>
						<div class="input-group">
							<span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></span>
							<input placeholder="Имя" type="text" class="form-control" id="comment_name" name="name" pattern="^[А-Яа-яЁё\s]+$" required maxlength="32" value="{$comment_name|escape}">
						</div>
						{if $error}{if $error=='empty_name'}
							<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
							<span class="sr-only">(ошибка)</span>
						{else $error!='captcha'}
							<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
							<span class="sr-only">(верно)</span>
						{/if}{/if}
					</div>
				</div>
				<div class="form-group{if $error && $error=='empty_comment'}has-error has-feedback{/if}">
					<label class="sr-only" for="comment_text">Коментарий</label>
					<div>
						<div class="input-group">
							<span class="input-group-addon" style="vertical-align: top;"><span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span></span>
							<textarea placeholder="Коментарий" class="form-control" id="comment_text" rows="7" name="text" required pattern=".+" maxlength="1024">{$comment_text}</textarea>
						</div>
						{if $error}{if $error=='empty_name'}
							<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
							<span class="sr-only">(ошибка)</span>
						{else $error!='captcha'}
							<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
							<span class="sr-only">(верно)</span>
						{/if}{/if}
					</div>
				</div>
				<div class="form-group{if $error && $error=='captcha'} has-error has-feedback{/if}">
					<label for="comment_captcha_code" class="sr-only">Капча</label>
					<div class="input-group form-group-lg">
						<span class="input-group-addon capcha"><span style="background-image: url(/captcha/image.php?{math equation='rand(10,10000)'});"></span></span>
						<input class="form-control" id="comment_captcha_code" name="captcha_code" type="text" value="" data-format="\d\d\d\d" required placeholder="Введите капчу">
					</div>
					{if $error && $error=='captcha'}
						<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
						<span class="sr-only">(ошибка)</span>
					{/if}
				</div>
				<small class="pull-right help-block">Все поля обязательны для заполнения</small>
				<input type="submit" class="btn btn-primary" name="comment" value="Отправить">
			</form>
		</div>
	</div>
</div>
