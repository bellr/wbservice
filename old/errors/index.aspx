<?php
if ($_GET['id'] == "403") {
	$error_message = "������ 403 - ������������ �� ������ ��������������, ������ �� ������";
}
if ($_GET['id'] == "404") {
	$error_message = "������ 404 - ������������� �������� �� ������";
}
if ($_GET['id'] == "500") {
	$error_message = "������ 500 - ���������� ������ �������";
}

require("../customsql.inc.aspx");
$db = new CustomSQL($DBName);

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>WM-RB.net - ������ ����������� �������� :: <? echo $error_message; ?></Title>
<Meta name="description" Content="������������������ �������� ����������� ����� WebMoney (WMZ, WMB, WMR, WME, WMU, WMY), EasyPay, RBK Money, Yandex Money, ������������ ������� � ������">
<Meta name="keywords" Content="�������� �����, ������������������ ��������, exchange, ����������� ������, wmb, wmz, wmr, wme, easypay, rbk money, yandex money, ������������������ �����, ������������������ �������, ����� �������� �����, ����� wm, ����������� ������ � ��������, ���������� ���� ����� WebMoney � ������, �������� webmoney, �����, ����� �����, ��������, �����, ��������, ���������, �������, ��������-������, ���������� ����, online change, ������ ��������, ����������, ������, ������������ ������� � ������, ����, ���, ��������� �����, ���������, ����������� ���������">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
<META content="30 days" name="revisit-after">
<META content="index,follow,all" name="robots">
<META name="author" content="AtomLy">
<META NAME="COPYRIGHT" CONTENT="Copyright (c) by Wm-Rb.net">
<link rel="stylesheet" href="http://wm-rb.net/style.css" type="text/css">
<link REL="shortcut icon" HREF="http://wm-rb.net/img/favicon.ico" TYPE="image/x-icon">
</SCRIPT>
</head>

<body>
<?
include('../include/top.aspx');
?>


	<tr>
	<td align="center" valign="middle" class="div_include"><h2 style="margin-top:190px;"><? echo $error_message; ?></h2></td>
	</tr>
<?
include('../include/bottom.aspx');
?>
</body>
</html>
