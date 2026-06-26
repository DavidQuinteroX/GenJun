<%@ Page Title="Productos" Language="C#" 
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Productos.aspx.cs"
    Inherits="DepsitoWeb.Productos" %>



<asp:Content ID="Content1" 
    ContentPlaceHolderID="MainContent" 
    runat="server">



<div class="container">


<h2>Productos</h2>



<asp:HiddenField 
    ID="hfIdProducto"
    runat="server" />



<div class="row">



<!-- FORMULARIO -->

<div class="col-md-4">


<label>Nombre Producto</label>


<asp:TextBox
    ID="txtNombre"
    runat="server"
    CssClass="form-control">
</asp:TextBox>



<br />



<label>Marca</label>


<asp:DropDownList
    ID="ddlMarca"
    runat="server"
    CssClass="form-control">
</asp:DropDownList>



<br />



<label>Categoría</label>


<asp:DropDownList
    ID="ddlCategoria"
    runat="server"
    CssClass="form-control">
</asp:DropDownList>




<br />



<label>Contenido ML</label>


<asp:TextBox
    ID="txtContenidoML"
    runat="server"
    CssClass="form-control">
</asp:TextBox>




<br />



<label>Activo</label>


<asp:CheckBox
    ID="chkActivo"
    runat="server"
    Text="Activo"/>



<br /><br />



<asp:Button
    ID="btnGuardar"
    runat="server"
    Text="Guardar"
    CssClass="btn btn-success"
    OnClick="btnGuardar_Click"/>



<asp:Button
    ID="btnActualizar"
    runat="server"
    Text="Actualizar"
    CssClass="btn btn-primary"
    Visible="false"
    OnClick="btnActualizar_Click"/>



</div>






<!-- TABLA -->

<div class="col-md-8">



<asp:GridView
    ID="gvProductos"
    runat="server"
    AutoGenerateColumns="False"
    CssClass="table table-bordered table-striped"
    OnRowCommand="gvProductos_RowCommand">



<Columns>



<asp:BoundField
    DataField="IdProducto"
    HeaderText="ID"/>




<asp:BoundField
    DataField="Nombre"
    HeaderText="Producto"/>




<asp:BoundField
    DataField="Marca"
    HeaderText="Marca"/>




<asp:BoundField
    DataField="Categoria"
    HeaderText="Categoría"/>




<asp:BoundField
    DataField="ContenidoML"
    HeaderText="ML"/>



<asp:CheckBoxField
    DataField="Activo"
    HeaderText="Activo"/>





<asp:TemplateField HeaderText="Acciones">


<ItemTemplate>



<asp:Button
    ID="btnEditar"
    runat="server"
    Text="Editar"
    CssClass="btn btn-warning btn-sm"
    CommandName="Editar"
    CommandArgument='<%# Eval("IdProducto") %>' />



&nbsp;



<asp:Button
    ID="btnEliminar"
    runat="server"
    Text="Eliminar"
    CssClass="btn btn-danger btn-sm"
    CommandName="Eliminar"
    CommandArgument='<%# Eval("IdProducto") %>' />



</ItemTemplate>


</asp:TemplateField>




</Columns>




</asp:GridView>



</div>


</div>


</div>



</asp:Content>