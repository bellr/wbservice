<?
class creat_demand_widget extends Template {
    function __construct($action_method,$vars='') {
        $this->vars = $vars;
        $this->$action_method();
    }

    private function block() {
        $P = inputData::init();
        $this->vars = (array)$P;

        $obj = Model::Uslugi($P->object);
        $pay = Model::Balance()->getCurrencyPay('st_pay');

        foreach($pay as $p) {
            $this->vars['item_pay'] .= parent::iterate_tmpl('exchanger',__CLASS__,'item_pay',$p);
        }

        if($obj->prop['name_cat'] == 'Banking') {
            $this->vars['testing'] = $this->iterate_tmpl('exchanger',__CLASS__,'testing');
        }

        $this->tmplName = 'select_pay';
        $this->vars['desc_uslugi'] = $obj->prop['desc_uslugi'];

        return $this->vars;
    }

    private function process() {
        $P = inputData::init();

        $html = Vitalis::tmpl('Widgets')->load_tmpl_block('exchanger.creat_demand.'.$P->controller,(array)$P);

        echo json_encode(array('status'=>0,'message'=>'','html'=>$html));
    }
}

?>