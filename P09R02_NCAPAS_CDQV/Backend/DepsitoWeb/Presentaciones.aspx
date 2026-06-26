<%@ Page Title="Presentaciones" Language="C#" 
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Presentaciones.aspx.cs"
    Inherits="DepsitoWeb.Presentaciones" %>


<asp:Content ID="Content1" 
    ContentPlaceHolderID="MainContent" 
    runat="server">


<h2>Presentaciones</h2>


<div class="row">


<div class="col-md-4">


    <asp:HiddenField 
        ID="hfIdPresentacion"
        runat="server" />


   <label>Producto</label>

<asp:DropDownList
    ID="ddlProducto"
    runat="server"
    CssClass="form-control">
</asp:DropDownList>


    <br />


    <label>Nombre Presentación</label>

    <asp:TextBox
        ID="txtNombre"
        runat="server"
        CssClass="form-control">
    </asp:TextBox>


    <br />


    <label>Cantidad</label>

    <asp:TextBox
        ID="txtCantidad"
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
    ID="gvPresentaciones"
    runat="server"
    AutoGenerateColumns="False"
    CssClass="table table-bordered"
    OnRowCommand="gvPresentaciones_RowCommand">


<Columns>


<asp:BoundField 
    DataField="IdPresentacion"
    HeaderText="ID"/>


<asp:BoundField
    DataField="Producto"
    HeaderText="Producto"/>


<asp:BoundField
    DataField="Nombre"
    HeaderText="Presentación"/>


<asp:BoundField
    DataField="Cantidad"
    HeaderText="Cantidad"/>



<asp:TemplateField HeaderText="Acciones">


<ItemTemplate>


<asp:Button
    ID="btnEditar"
    runat="server"
    Text="Editar"
    CommandName="Editar"
    CommandArgument='<%# Eval("IdPresentacion") %>'
    CssClass="btn btn-warning"/>



<asp:Button
    ID="btnEliminar"
    runat="server"
    Text="Eliminar"
    CommandName="Eliminar"
    CommandArgument='<%# Eval("IdPresentacion") %>'
    CssClass="btn btn-danger"/>


</ItemTemplate>


</asp:TemplateField>



</Columns>


</asp:GridView>


</div>


</div>


</asp:Content>