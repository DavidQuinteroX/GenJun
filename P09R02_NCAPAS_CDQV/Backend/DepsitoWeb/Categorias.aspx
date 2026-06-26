<%@ Page Title="Categorías" Language="C#" MasterPageFile="~/Site.Master" 
    AutoEventWireup="true" CodeBehind="Categorias.aspx.cs" 
    Inherits="DepsitoWeb.Categorias" %>


<asp:Content ID="Content1" 
    ContentPlaceHolderID="MainContent" 
    runat="server">



<div class="container">


<h2>Categorías</h2>



<asp:HiddenField 
    ID="hfIdCategoria"
    runat="server" />



<div class="row">



<div class="col-md-4">



    <div class="form-group">

        <label>Nombre Categoría</label>


        <asp:TextBox
            ID="txtNombre"
            runat="server"
            CssClass="form-control">
        </asp:TextBox>


    </div>



    <br />



    <asp:Button
        ID="btnGuardar"
        runat="server"
        Text="Guardar"
        CssClass="btn btn-success"
        OnClick="btnGuardar_Click" />



    <asp:Button
        ID="btnActualizar"
        runat="server"
        Text="Actualizar"
        CssClass="btn btn-primary"
        OnClick="btnActualizar_Click" />



</div>





<div class="col-md-8">





<asp:GridView
    ID="gvCategorias"
    runat="server"
    AutoGenerateColumns="False"
    CssClass="table table-bordered table-striped"
    OnRowCommand="gvCategorias_RowCommand">



<Columns>



<asp:BoundField
    DataField="IdCategoria"
    HeaderText="ID" />





<asp:BoundField
    DataField="Nombre"
    HeaderText="Categoría" />






<asp:TemplateField HeaderText="Acciones">


<ItemTemplate>



<asp:Button
    ID="btnEditar"
    runat="server"
    Text="Editar"
    CssClass="btn btn-warning"
    CommandName="Editar"
    CommandArgument='<%# Eval("IdCategoria") %>' />



&nbsp;



<asp:Button
    ID="btnEliminar"
    runat="server"
    Text="Eliminar"
    CssClass="btn btn-danger"
    CommandName="Eliminar"
    CommandArgument='<%# Eval("IdCategoria") %>' />



</ItemTemplate>


</asp:TemplateField>




</Columns>



</asp:GridView>




</div>


</div>


</div>



</asp:Content>