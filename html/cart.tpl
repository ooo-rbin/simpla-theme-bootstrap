{$meta_title="Корзина" scope=parent}{$meta_robots="noindex, nofollow, noarchive" scope=parent}
<nav>
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		<li class="active">Корзина</li>
	</ol>
</nav>
<h1>{if $cart->total_products}В корзине {$cart->total_products} {$cart->total_products|plural:'товар':'товаров':'товара'}{else}Корзина пуста{/if}</h1>
{if $cart->total_products}
	<form method="post" name="cart" class="">
		{if $cart->purchases}
			<div class="table-responsive">
				<table id="purchases" class="table table-striped">
					<caption>Товары</caption>
					<thead>
						<tr>
							<th>Наименование</th>
							<th>Стоимость</th>
							<th>Количество</th>
							<th>Сумма</th>
							<th>&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						{foreach $cart->purchases as $purchase}<tr>
								<th>
									<a  href="/products/{$purchase->product->url}">
										{$image = $purchase->product->images|first}{if $image}<img src="{$image->filename|resize:55:55}" alt="{$product->name|escape}" >{/if}
										{$purchase->product->name|escape}
										{if $purchase->variant_name}<br><small>({$purchase->variant_name|escape})</small>{/if}
									</a>
								</th>
								<td class="text-right number">
									<span class="form-control-static">{($purchase->variant->price)|convert}&nbsp;{$currency->sign}</span>
								</td>
								<td class="number">
									<select class="form-control" name="amounts[{$purchase->variant->id}]" onchange="document.cart.submit();">
										{section name=amounts start=1 loop=$purchase->variant->stock+1 step=1}
											<option value="{$smarty.section.amounts.index}" {if $purchase->amount==$smarty.section.amounts.index}selected{/if}>{$smarty.section.amounts.index} {$settings->units}</option>
										{/section}
									</select>
								</td>
								<td class="text-right number">
									<span class="form-control-static">{($purchase->variant->price*$purchase->amount)|convert}&nbsp;{$currency->sign}</span>
								</td>
								<td>
									<a class="btn btn-danger" title="Удалить из корзины" href="cart/remove/{$purchase->variant->id}">
										<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
										<span class="sr-only">Удалить из корзины</span>
									</a>
								</td>
						</tr>{/foreach}
					</tbody>
					<tfoot>
						{if $user->discount}<tr>
							<th colspan="3" class="text-right">Скидка</th>
							<td class="text-right number text-success">&minus;{$user->discount}%</td>
							<td>&nbsp;</td>
						</tr>{/if}
						{if $coupon_request}<tr>
							<th colspan="3" class="text-right form">
								<div class="form-group">
									<div class="input-group pull-right">
										<label class="input-group-addon" for="coupon_code">Код на скидку:</label>
										<input class="form-control" aria-describedby="helpBlock" type="text" id="coupon_code" name="coupon_code" value="{$cart->coupon->code|escape}">
										<span class="input-group-btn">
											<button class="btn btn-default" type="submit" name="apply_coupon">Применить</button>
										</span>
									</div>
								</div>
								<div id="helpBlock" class="help-block">
									{if $coupon_error}<p class="text-danger">{if $coupon_error == 'invalid'}Купон недействителен{/if}</p>{/if}
									{if $cart->coupon->min_order_price>0}<p class="text-info">Купон {$cart->coupon->code|escape} действует для заказов от {$cart->coupon->min_order_price|convert} {$currency->sign}</p>{/if}
								</div>
							</th>
							<td class="text-right number text-success">{if $cart->coupon_discount>0}&minus;{$cart->coupon_discount|convert}&nbsp;{$currency->sign}{/if}</td>
							<td>&nbsp;</td>
						</tr>{/if}
						<tr>
							<th colspan="3" class="text-right h3"><strong>Итого</strong></th>
							<td class="text-right number h3"><strong>{$cart->total_price|convert}&nbsp;{$currency->sign}</strong></td>
							<th>&nbsp;</th>
						</tr>
					</tfoot>
				</table>
			</div>
		{/if}
		{if $cart->requests}
			<div class="table-responsive">
				<table id="requests" class="table table-striped">
					<caption>Заказы</caption>
					<thead>
						<tr>
							<th>Наименование</th>
							<th>Количество</th>
							<th>&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						{foreach $cart->requests as $request}<tr>
							<th>
								<a href="/products/{$request->url}">
									{$image = $request->images|first}{if $image}<img src="{$image->filename|resize:55:55}" alt="{$request->name|escape}" >{/if}
									{$request->name|escape}
								</a>
							</th>
							<td class="number">
								<input class="form-control" type="number" step="1" min="1" max="1000" name="requests[{$request->id}]" value="{$request->amount}">
							</td>
							<td>
								<a class="btn btn-danger" title="Удалить из корзины" href="cart/remove_request/{$request->id}">
									<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
									<span class="sr-only">Удалить из корзины</span>
								</a>
							</td>
						</tr>{/foreach}
					</tbody>
					<tfoot>
						<tr><td colspan="3" class="text-info"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Ваши запросы на эти товары будут обработы менеджером после оформления заказа.</td></tr>
					</tfoot>
				</table>
			</div>
		{/if}		
		{if $deliveries}
			<div id="deliveries" class="panel panel-default">
				<h2 class="panel-heading">Выберите способ доставки:</h2>
				<div class="list-group">
					{foreach $deliveries as $delivery}
						<input type="radio" name="delivery_id" value="{$delivery->id}" {if $delivery_id==$delivery->id}checked{elseif $delivery@first}checked{/if} id="deliveries_{$delivery->id}" class="hidden list-group-item-radio">
						<label class="list-group-item" for="deliveries_{$delivery->id}">
							<h3 class="list-group-item-heading">{$delivery->name}{if $cart->total_price<$delivery->free_from && $delivery->price>0} ({$delivery->price|convert}&nbsp;{$currency->sign}){elseif $cart->total_price >= $delivery->free_from} (бесплатно){/if}<span class="badge hidden"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></span></h3>
							<div class="list-group-item-text">{$delivery->description}</div>
						</label>
					{/foreach}
				</div>
			</div>
		{/if}
		<div id="contacts" class="panel {if $error}panel-danger{else}panel-default{/if}">
			<h2 class="panel-heading">Адрес получателя:</h2>
			<div class="panel-body form-horizontal">         
				{if $error}
					<p class="well well-sm text-danger">
						{if $error == 'empty_name'}Введите имя{/if}
						{if $error == 'empty_email'}Введите email{/if}
						{if $error == 'captcha'}Капча введена неверно{/if}
					</p>
				{/if}
				<div class="row form-group{if $error} {if $error=='empty_name'}has-error has-feedback{else}has-success has-feedback{/if}{/if}">
					<label for="deliveries_name" class="col-sm-3 control-label text-right">Имя, фамилия <span class="glyphicon glyphicon-exclamation-circle" aria-hidden="true"></span></label>
					<div class="col-sm-9">
						<input class="form-control" id="deliveries_name" name="name" type="text" value="{$name|escape}" data-format=".+" data-notice="Введите имя">
						{if $error}{if $error=='empty_name'}
							<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
							<span class="sr-only">(ошибка)</span>
						{else}
							<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
							<span class="sr-only">(верно)</span>
						{/if}{/if}
					</div>
				</div>
				<div class="row form-group{if $error} {if $error=='empty_email'}has-error has-feedback{elseif $error!='empty_name'}has-success has-feedback{/if}{/if}">
					<label for="deliveries_email" class="col-sm-3 control-label text-right">Email <span class="glyphicon glyphicon-exclamation-circle" aria-hidden="true"></span></label>
					<div class="col-sm-9">
						<input class="form-control" id="deliveries_email" name="email" type="text" value="{$email|escape}" data-format="email" data-notice="Введите email">
						{if $error}{if $error=='empty_email'}
							<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
							<span class="sr-only">(ошибка)</span>
						{elseif $error!='empty_name'}
							<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
							<span class="sr-only">(верно)</span>
						{/if}{/if}
					</div>
				</div>
				<div class="row form-group">
					<label for="deliveries_phone" class="col-sm-3 control-label text-right">Телефон</label>
					<div class="col-sm-9">
						<input class="form-control" id="deliveries_phone" name="phone" type="text" value="{$phone|escape}">
					</div>
				</div>
				<div class="row form-group">
					<label for="deliveries_address" class="col-sm-3 control-label text-right">Адрес доставки</label>
					<div class="col-sm-9">
						<input class="form-control" id="deliveries_address" name="address" type="text" value="{$address|escape}">
					</div>
				</div>
				<div class="row form-group">
					<label for="deliveries_comment" class="col-sm-3 control-label text-right">Комментарий к&nbsp;заказу</label>
					<div class="col-sm-9">
						<textarea class="form-control" rows="5" id="deliveries_comment" name="comment">{$comment|escape}</textarea>
					</div>
				</div>
				<div class="row form-group{if $error|default:false=='captcha'} has-error has-feedback{/if}">
					<label for="deliveries_captcha_code" class="col-sm-3 control-label text-right">Введите капчу <span class="glyphicon glyphicon-exclamation-circle" aria-hidden="true"></span></label>
					<div class="col-sm-9">
						<div class="input-group form-group-lg">
							<span class="input-group-addon capcha"><span style="background-image: url(/captcha/image.php?{math equation='rand(10,10000)'});"></span></span>
							<input class="form-control" id="deliveries_captcha_code" name="captcha_code" type="text" value="" data-format="\d\d\d\d" data-notice="Введите капчу">
						</div>
						{if $error|default:false=='captcha'}
							<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
							<span class="sr-only">(ошибка)</span>
						{/if}
					</div>
				</div>
				<div class="row form-group">
					<div class="col-sm-offset-3 col-sm-9">
						<small class="pull-right help-block"><span class="glyphicon glyphicon-exclamation-circle" aria-hidden="true"></span> - обязательно для заполнения</small>
						<button type="submit" name="checkout" class="btn btn-primary">Оформить заказ</button>
					</div>
				</div>
			</div>
		</div>
	</form>
{else}
  В корзине нет товаров
{/if}
