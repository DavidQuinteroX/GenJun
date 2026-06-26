<%--<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="DepsitoWeb.Marcas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>--%>

<%@ Page Title="Marcas" Language="C#" 
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Marcas.aspx.cs"
    Inherits="DepsitoWeb.Marcas" %>


<asp:Content ID="Content1" 
    ContentPlaceHolderID="MainContent" 
    runat="server">


<div class="container">


<h2>Marcas</h2>


<asp:HiddenField 
    ID="hfIdMarca"
    runat="server" />



<div class="row">


<div class="col-md-4">


<label>Nombre Marca</label>


<asp:TextBox
    ID="txtNombre"
    runat="server"
    CssClass="form-control">
</asp:TextBox>



<br />



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




<div class="col-md-8">



<asp:GridView
    ID="gvMarcas"
    runat="server"
    AutoGenerateColumns="False"
    CssClass="table table-bordered"
    OnRowCommand="gvMarcas_RowCommand">



<Columns>


<asp:BoundField
    DataField="IdMarca"
    HeaderText="ID"/>



<asp:BoundField
    DataField="Nombre"
    HeaderText="Marca"/>




<asp:TemplateField HeaderText="Acciones">


<ItemTemplate>



<asp:Button
    ID="btnEditar"
    runat="server"
    Text="Editar"
    CssClass="btn btn-warning"
    CommandName="Editar"
    CommandArgument='<%# Eval("IdMarca") %>' />



<asp:Button
    ID="btnEliminar"
    runat="server"
    Text="Eliminar"
    CssClass="btn btn-danger"
    CommandName="Eliminar"
    CommandArgument='<%# Eval("IdMarca") %>' />



</ItemTemplate>


</asp:TemplateField>



</Columns>



</asp:GridView>



</div>


</div>


</div>



</asp:Content>
