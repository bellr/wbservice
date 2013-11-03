<?
class footer_widget extends Template {
    function __construct($action_method,$vars='') {
        $this->$action_method();
    }

    private function block() {
        $this->vars['footer'] = Vitalis::tmpl('Widgets')->load_tmpl_block('inc.footer');
        return $this->vars;
    }
}

?>