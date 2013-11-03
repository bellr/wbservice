
<?
//https://merchant.webmoney.ru/lmi/payment.asp
echo "
<form name=\"check_demand\" id=\"check_demand\" method=\"post\" action=\"http://service.wm-rb.net/check_demand.aspx\" onSubmit=\"return Check()\">
                    <table width=\"420\" border=\"0\" cellspacing=\"1\" cellpadding=\"10\" bgColor=\"#ebebeb\">
                      <tr>
                        <td colspan=\"2\" align=\"center\" class=\"text\" height=\"40\" background=\"http://wm-rb.net/img/linet.gif\">{$Cons_uslugi->name_oper($type_usluga,$us[0]['desc_val'])}</td>
                      </tr>
                      <tr bgColor=\"#f3f7ff\">
                        <td colspan=\"2\" align=\"center\" class=\"text_log\"><b>Заявка  № $reqID</b></td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\" width=\"110\" >Отдаете, {$currency}:&nbsp;</td>
                        <td align=\"center\">

                          <input type=\"text\" name=\"in_val\" size=\"13\" value=\"0\" id=\"in_val\"
                  onblur=\"i_o(true)\" onkeyup=\"i_o()\" onchange=\"i_o()\">
                        </td>
                      </tr>
                      <tr bgColor=\"#f3f7ff\">
                        <td colspan=\"2\" align=\"left\" class=\"text_log\"><b>Вы должны иметь, {$Cons_uslugi->output($type_usluga,$oplata)}: </b>
                          <SPAN id=kom_08>0</SPAN>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\" height=\"4\">Получаете, {$Cons_uslugi->input($type_usluga,$oplata)}:&nbsp;</td>
                        <td align=\"center\" height=\"4\">
                          <input type=\"text\" name=\"out_val\" size=\"13\" value=\"0\" id=\"out_val\"
                  onblur=\"o_i(true)\" onkeyup=\"o_i()\" onchange=\"o_i()\">
                        </td>
                      </tr>
                      <tr bgColor=\"#f3f7ff\">
                        <td colspan=\"2\" align=\"left\" class=\"text_log\"><b>Доступно для оплаты, {$Cons_uslugi->input($type_usluga,$oplata)}: {$format_balance}</b></td>
			          </tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">";
switch ($_POST['type_usluga']) :
	case ("NAL") : $Constructor->check("",$oplata,"",$_COOKIE['purse_'.$oplata]); break;
	case ("output_NAL") : $Constructor->check($oplata,"",$_COOKIE['purse_'.$oplata],""); break;
	case ("uslugi") : $Constructor->check($oplata,"",$_COOKIE['purse_'.$oplata],""); break;
	endswitch;
					echo "</td>
					</tr>
					<tr class=\"text\" bgColor=\"#ffffff\">";
						$Constructor->inside_input($usluga,$_COOKIE[$usluga.'_1'],$_COOKIE[$usluga.'_2']);
					  echo "
					</td>
					</tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\">E-Mail :&nbsp;<br>
                        </td>
                        <td align=\"center\">
			  <input type=\"text\" name=\"email\" id=\"email\" value=\"".$_COOKIE['email']."\" size=\"20\">
                        </td>
                      </tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
                        <td colspan=\"2\" align=\"center\">
			<div class=\"text\">C <a href=\"http://wm-rb.net/rules.aspx\" target=\"_blank\" title=\"Правила предоставления услуг\">правилами</a> предоставления услуг согласен <input type=\"checkbox\" name=\"rules\"></div></td>
                      </tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
						<td colspan=\"2\" align=\"center\">


					<input type=\"hidden\" name=\"oplata\" value=\"$oplata\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"name_uslugi\" value=\"$usluga\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"did\" value=\"$reqID\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"hesh\" value=\""; echo md5($reqID.'1620'); echo "\" readonly=\"readonly\">
                    <input type=\"submit\" name=\"{$Cons_uslugi->name_submit($type_usluga)}\" value=\"Продолжить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\">
			</tr>
			</td>
</table>
                    </form>";
?>
