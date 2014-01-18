<?
class header_widget extends Template {

    public  function block() {

        $this->vars['header'] = Vitalis::tmpl('Widgets')->load_tmpl_block('inc.header');

        return $this;
    }
}

?>