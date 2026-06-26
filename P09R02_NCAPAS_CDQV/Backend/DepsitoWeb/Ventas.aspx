<%@ Page Title="Ventas" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Ventas.aspx.cs"
    Inherits="DepsitoWeb.Ventas" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


<div class="ventas-container">


    <!-- CABECERA -->

    <div class="ventas-header">

        <div>

            <h2>
                <span class="material-icons">
                    point_of_sale
                </span>

                Registro de Venta
            </h2>

            <p>
                Registra una nueva venta del depósito
            </p>

        </div>


        <div class="ventas-total-box">

            <small>Total</small>

            <h2>
                $
                <asp:Label 
                    ID="lblTotalVista"
                    runat="server"
                    Text="0.00"/>
            </h2>

        </div>


    </div>



    <asp:Label 
        ID="lblMensaje"
        runat="server"
        CssClass="mensaje-venta">
    </asp:Label>



    <!-- DATOS VENTA -->


    <div class="card-venta">


        <div class="card-title">

            <span class="material-icons">
                receipt_long
            </span>

            Datos de la venta

        </div>



        <div class="row g-3">


            <div class="col-md-6">


                <label>
                    Cliente
                </label>


                <asp:DropDownList
                    ID="ddlClientes"
                    runat="server"
                    CssClass="form-select">
                </asp:DropDownList>


            </div>



            <div class="col-md-3">


                <label>
                    Fecha
                </label>


                <asp:TextBox
                    ID="txtFecha"
                    runat="server"
                    CssClass="form-control"
                    TextMode="Date"
                    Enabled="false">
                </asp:TextBox>


            </div>



            <div class="col-md-3">


                <label>
                    Total
                </label>


                <asp:TextBox
                    ID="txtTotal"
                    runat="server"
                    CssClass="form-control"
                    ReadOnly="true">
                </asp:TextBox>


            </div>


        </div>


    </div>





    <!-- PRODUCTO -->


    <div class="card-venta mt-4">


        <div class="card-title">


            <span class="material-icons">
                inventory_2
            </span>


            Agregar productos


        </div>



        <div class="row g-3 align-items-end">



            <div class="col-md-5">


                <label>
                    Producto
                </label>


                <asp:DropDownList
                    ID="ddlPresentaciones"
                    runat="server"
                    CssClass="form-select">
                </asp:DropDownList>


            </div>




            <div class="col-md-2">


                <label>
                    Cantidad
                </label>


                <asp:TextBox
                    ID="txtCantidad"
                    runat="server"
                    CssClass="form-control">
                </asp:TextBox>


            </div>




            <div class="col-md-3">


                <label>
                    Precio
                </label>


                <asp:TextBox
                    ID="txtPrecio"
                    runat="server"
                    CssClass="form-control">
                </asp:TextBox>


            </div>




            <div class="col-md-2">


                <asp:Button
                    ID="btnAgregarDetalle"
                    runat="server"
                    Text="Agregar"
                    CssClass="btn btn-warning w-100"
                    OnClick="btnAgregarDetalle_Click"/>


            </div>



        </div>


    </div>





    <!-- DETALLE -->


    <div class="card-venta mt-4">



        <div class="card-title">


            <span class="material-icons">
                shopping_cart
            </span>


            Detalle de productos


        </div>





        <asp:GridView
            ID="gvDetalle"
            runat="server"
            AutoGenerateColumns="false"
            CssClass="table table-hover tabla-venta">


            <Columns>


                <asp:BoundField
                    DataField="Producto"
                    HeaderText="Producto"/>



                <asp:BoundField
                    DataField="Presentacion"
                    HeaderText="Presentación"/>



                <asp:BoundField
                    DataField="Cantidad"
                    HeaderText="Cantidad"/>



                <asp:BoundField
                    DataField="PrecioUnitario"
                    HeaderText="Precio"/>



                <asp:BoundField
                    DataField="Subtotal"
                    HeaderText="Subtotal"/>


            </Columns>


        </asp:GridView>




    </div>





    <!-- BOTON -->


    <div class="venta-footer">


        <asp:Button
            ID="btnGuardar"
            runat="server"
            Text="Guardar Venta"
            CssClass="btn btn-success btn-lg"
            OnClick="btnGuardar_Click"/>


    </div>



</div>


</asp:Content>