<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Precios.aspx.cs" Inherits="DepsitoWeb.Precios" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <h2>Precios</h2>


    <asp:HiddenField
        ID="hfIdPrecio"
        runat="server" />


    <div>
        <asp:Label
            Text="Presentación"
            runat="server" />


        <asp:DropDownList
            ID="ddlPresentacion"
            runat="server"
            CssClass="form-control">
        </asp:DropDownList>


        <br />


        <asp:Label
            Text="Precio"
            runat="server" />


        <asp:TextBox
            ID="txtPrecio"
            runat="server"
            CssClass="form-control">
        </asp:TextBox>

       


        <br />


        <asp:Button
            ID="btnGuardar"
            runat="server"
            Text="Guardar"
            CssClass="btn btn-primary"
            OnClick="btnGuardar_Click" />



        <asp:Button
            ID="btnActualizar"
            runat="server"
            Text="Actualizar"
            Visible="false"
            CssClass="btn btn-warning"
            OnClick="btnActualizar_Click" />


    </div>



    <br />


    <asp:GridView
        ID="gvPrecios"
        runat="server"
        AutoGenerateColumns="False"
        CssClass="table"
        OnRowCommand="gvPrecios_RowCommand">


        <Columns>


            <asp:BoundField
                DataField="IdPrecio"
                HeaderText="ID" />


            <asp:BoundField
                DataField="Producto"
                HeaderText="Producto" />


            <asp:BoundField
                DataField="Presentacion"
                HeaderText="Presentación" />


            <asp:BoundField
                DataField="Precio"
                HeaderText="Precio" />


            <asp:BoundField
                DataField="FechaInicio"
                HeaderText="Inicio"
                DataFormatString="{0:dd/MM/yyyy}" />


            <asp:BoundField
                DataField="FechaFin"
                HeaderText="Fin"
                DataFormatString="{0:dd/MM/yyyy}" />



            <asp:TemplateField HeaderText="Acciones">


                <ItemTemplate>


                    <asp:Button
                        ID="btnEditar"
                        runat="server"
                        Text="Editar"
                        CommandName="Editar"
                        CommandArgument='<%# Eval("IdPrecio") %>'
                        CssClass="btn btn-success" />



                    <asp:Button
                        ID="btnEliminar"
                        runat="server"
                        Text="Eliminar"
                        CommandName="Eliminar"
                        CommandArgument='<%# Eval("IdPrecio") %>'
                        CssClass="btn btn-danger" />


                </ItemTemplate>


            </asp:TemplateField>



        </Columns>


    </asp:GridView>


</asp:Content>
