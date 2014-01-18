<?
class footer_widget extends Template {

    public function block() {
        $this->vars['footer'] = Vitalis::tmpl('Widgets')->load_tmpl_block('inc.footer');
        return $this;
    }
}

?>