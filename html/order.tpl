{$meta_title = "Ваш заказ №`$order->id`" scope=parent}{$meta_robots="noindex, nofollow, noarchive" scope=parent}
<nav>
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		<li><a href="/user">Пользователь</a></li>
		<li class="active">Заказ №{$order->id}</li>
	</ol>
</nav>
<h1>Ваш заказ №{$order->id}{if $order->status == 0} принят{/if}{if $order->status == 1} в обработке{elseif $order->status == 2} выполнен{/if}{if $order->paid == 1}, оплачен{else}{/if}</h1>
<div class="table-responsive">
	<table id="purchases" class="table table-striped">
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
			{foreach $purchases as $purchase}<tr>
				<th>
					<a  href="/products/{$purchase->product->url}">
						{$image = $purchase->product->images|first}{if $image}<img src="{$image->filename|resize:50:50}" alt="{$product->name|escape}" >{/if}
						{$purchase->product_name|escape}
						{if $purchase->variant_name}<br><small>({$purchase->variant_name|escape})</small>{/if}
					</a>
				</th>
				<td class="text-right number">
					<span class="form-control-static">{if $purchase->price>0}{($purchase->price)|convert}&nbsp;{$currency->sign}{else}{assign var='has_requests' value=1}Уточняется{/if}</span>
				</td>
				<td class="text-right number">
					<span class="form-control-static">&times;&nbsp;{$purchase->amount}&nbsp;{$settings->units}</span>
				</td>
				<td class="text-right number">
					<span class="form-control-static">{if $purchase->price>0}{($purchase->price*$purchase->amount)|convert}&nbsp;{$currency->sign}{else}&nbsp;{/if}</span>
				</td>
				<td>{if $order->paid && $purchase->variant->attachment}
					<a class="btn btn-success" title="Ссылка на файл" target="_blank" href="/order/{$order->url}/{$purchase->variant->attachment}">
						<span class="glyphicon glyphicon-link" aria-hidden="true"></span>
						<span class="sr-only">Ссылка на файл</span>
					</a>
				{/if}</td>
			</tr>{/foreach}
		</tbody>
		<tfoot>
			{if $order->discount > 0}<tr>
				<th colspan="3" class="text-right">Скидка</th>
				<td class="text-right number text-success">&minus;{$order->discount}%</td>
				<td>&nbsp;</td>
			</tr>{/if}
			{if $order->coupon_discount > 0}<tr>
				<th colspan="3" class="text-right">Купон</th>
				<td class="text-right number text-success">&minus;{$order->coupon_discount|convert}&nbsp;{$currency->sign}</td>
				<td>&nbsp;</td>
			</tr>{/if}
			{if !$order->separate_delivery && $order->delivery_price>0}<tr>
				<th colspan="3" class="text-right">{$delivery->name|escape}</th>
				<td class="text-right number">{$order->delivery_price|convert}&nbsp;{$currency->sign}</td>
				<td>&nbsp;</td>
			</tr>{/if}
			{if $order->total_price>0}<tr>
				<th colspan="3" class="text-right h3"><strong>Итого</strong></th>
				<td class="number h3"><strong>{if $has_requests}от&nbsp;{/if}{$order->total_price|convert}&nbsp;{$currency->sign}</strong></td>
				<th>&nbsp;</th>
			</tr>{/if}
			{if $order->separate_delivery}<tr>
				<th colspan="3" class="text-right">{$delivery->name|escape}</th>
				<td class="text-right number">{$order->delivery_price|convert}&nbsp;{$currency->sign}</td>
				<td>&nbsp;</td>
			</tr>{/if}
		</tfoot>
	</table>
</div>
<div id="contacts" class="panel panel-default">
	<h2 class="panel-heading">Детали заказа:</h2>
	<div class="panel-body">
		<div class="row">
			<strong class="col-sm-3 text-right">Дата заказа</strong>
			<p class="col-sm-9">{$order->date|date} в {$order->date|time}</p>
		</div>
		{if $order->name}<div class="row">
			<strong class="col-sm-3 text-right">Имя</strong>
			<p class="col-sm-9">{$order->name|escape}</p>
		</div>{/if}
		{if $order->email}<div class="row">
			<strong class="col-sm-3 text-right">Email</strong>
			<p class="col-sm-9">{$order->email|escape}</p>
		</div>{/if}
		{if $order->phone}<div class="row">
			<strong class="col-sm-3 text-right">Телефон</strong>
			<p class="col-sm-9">{$order->phone|escape}</p>
		</div>{/if}
		{if $order->address}<div class="row">
			<strong class="col-sm-3 text-right">Адрес доставки</strong>
			<p class="col-sm-9">{$order->address|escape}</p>
		</div>{/if}
		{if $order->comment}<div class="row">
			<strong class="col-sm-3 text-right">Комментарийи</strong>
			<p class="col-sm-9">{$order->comment|escape|nl2br}</p>
		</div>{/if}
		{if $has_requests}<div class="row">
			<strong class="col-sm-3 text-right">Дополнительно</strong>
			<p class="col-sm-9">Требует обработки менеджером для проведения оплаты</p>
		</div>{/if}
	</div>
</div>
{if !$order->paid && !$has_requests}{if $payment_methods && !$payment_method && $order->total_price>0}<form method="post" id="deliveries" class="panel panel-default">
	<h2 class="panel-heading">Выберите способ оплаты:</h2>
	<div class="list-group">{foreach $payment_methods as $payment_method}
		<input type="radio" name="payment_method_id" value="{$payment_method->id}" {if $payment_method@first}checked{/if} id="payment_{$payment_method->id}" class="hidden list-group-item-radio">
		<label class="list-group-item" for="payment_{$payment_method->id}">
			<h3 class="list-group-item-heading">{$payment_method->name}, к оплате {$order->total_price|convert:$payment_method->currency_id}&nbsp;{$all_currencies[$payment_method->currency_id]->sign}<span class="badge hidden"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></span></h3>
			<div class="list-group-item-text">{$payment_method->description}</div>
		</label>
	{/foreach}</div>
	<div class="panel-footer"><button type="submit" class="btn btn-primary">Закончить заказ</button></div>
</form>{elseif $payment_method}<div id="deliveries" class="panel panel-default">
	<h2 class="panel-heading">Способ оплаты &mdash; {$payment_method->name}</h2>
	<div class="panel-body">
		{$payment_method->description}
		<form method="post" class="form-inline">
			<strong class="form-control-static">К оплате {$order->total_price|convert:$payment_method->currency_id}&nbsp;{$all_currencies[$payment_method->currency_id]->sign}</strong>
			<button class="pull-right btn btn-default" type="submit" name="reset_payment_method" value="1">Выбрать другой способ оплаты</button><div class="clearfix"></div>
		</form>
	</div>
	<div id="checkout" class="panel-footer">{checkout_form order_id=$order->id module=$payment_method->module}</div>
</div>{/if}{/if}
