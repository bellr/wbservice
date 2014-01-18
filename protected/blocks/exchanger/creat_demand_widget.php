<?
class creat_demand_widget extends Template {

    public function block($P) {

        $obj = $this->vars = Model::Seo_pattern()->getInfoModel();
        $pay = Model::Balance('HOME')->getCurrencyPay('st_pay');

        foreach($pay as $p) {
            $this->vars['item_pay'] .= parent::iterate_tmpl('exchanger',__CLASS__,'item_pay',$p);
        }

        if($obj->prop['name_cat'] == 'Banking') {
            $this->vars['testing'] = $this->iterate_tmpl('exchanger',__CLASS__,'testing');
        }

        $this->tmplName = 'select_pay';
        $this->vars['desc_uslugi'] = $obj['title'];
        $this->vars['object'] = $P->object;

        return $this;
    }

    public function process($P) {

        $P->controller = $P->type_oper;
        $html = Vitalis::tmpl('Widgets')->load_tmpl_block('exchanger.creat_demand.'.$P->controller,(array)$P);

        return json_encode(array('status'=>0,'message'=>'','html'=>$html));
    }
}

?>