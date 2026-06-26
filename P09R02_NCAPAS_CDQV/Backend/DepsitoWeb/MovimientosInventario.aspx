<%@ Page Title="Movimientos Inventario"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="MovimientosInventario.aspx.cs"
    Inherits="DepsitoWeb.MovimientosInventario" %>



<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">


<div class="dashboard-container">



    <!-- CABECERA -->

    <div class="dashboard-header">


        <h2>

            <span class="material-icons">
                sync_alt
            </span>

            Movimientos de Inventario

        </h2>


        <p>
            Control de entradas y salidas de productos
        </p>


    </div>





    <asp:HiddenField
        ID="hfIdMovimiento"
        runat="server" />



    <asp:Label
        ID="lblMensaje"
        runat="server"
        CssClass="text-success">
    </asp:Label>





    <div class="row mt-4">





        <!-- FORMULARIO -->


        <div class="col-lg-4">


            <div class="dashboard-panel">


                <h5>

                    <span class="material-icons">
                        inventory
                    </span>

                    Registrar Movimiento

                </h5>




                <div class="mb-3">


                    <label class="form-label">
                        Producto / Presentación
                    </label>


                    <asp:DropDownList
                        ID="ddlPresentacion"
                        runat="server"
                        CssClass="form-select">
                    </asp:DropDownList>


                </div>





                <div class="mb-3">


                    <label class="form-label">
                        Tipo Movimiento
                    </label>


                    <asp:DropDownList
                        ID="ddlTipoMovimiento"
                        runat="server"
                        CssClass="form-select">


                        <asp:ListItem
                            Text="Entrada"
                            Value="ENTRADA"/>


                        <asp:ListItem
                            Text="Salida"
                            Value="SALIDA"/>


                    </asp:DropDownList>


                </div>





                <div class="mb-3">


                    <label class="form-label">
                        Cantidad
                    </label>


                    <asp:TextBox
                        ID="txtCantidad"
                        runat="server"
                        CssClass="form-control">
                    </asp:TextBox>


                </div>





                <div class="mb-3">


                    <label class="form-label">
                        Fecha
                    </label>


                    <asp:TextBox
                        ID="txtFecha"
                        runat="server"
                        CssClass="form-control">
                    </asp:TextBox>


                </div>





                <div class="mb-3">


                    <label class="form-label">
                        Motivo
                    </label>


                    <asp:TextBox
                        ID="txtMotivo"
                        runat="server"
                        CssClass="form-control">
                    </asp:TextBox>


                </div>






                <div class="d-flex gap-2">


                    <asp:Button
                        ID="btnGuardar"
                        runat="server"
                        Text="Guardar"
                        CssClass="btn btn-warning"
                        OnClick="btnGuardar_Click" />



                    <asp:Button
                        ID="btnCancelar"
                        runat="server"
                        Text="Cancelar"
                        CssClass="btn btn-secondary"
                        OnClick="btnCancelar_Click" />


                </div>



            </div>


        </div>









        <!-- TABLA -->



        <div class="col-lg-8">


            <div class="dashboard-panel">



                <h5>

                    <span class="material-icons">
                        table_view
                    </span>


                    Movimientos registrados


                </h5>





                <div class="table-responsive">



                <asp:GridView
                    ID="gvMovimientos"
                    runat="server"
                    AutoGenerateColumns="false"
                    CssClass="table table-hover align-middle">



                <Columns>



                <asp:BoundField
                    DataField="IdMovimiento_Inventario"
                    HeaderText="ID"/>



                <asp:BoundField
                    DataField="Producto"
                    HeaderText="Producto"/>



                <asp:BoundField
                    DataField="Presentacion"
                    HeaderText="Presentación"/>



                <asp:BoundField
                    DataField="TipoMovimiento"
                    HeaderText="Tipo"/>



                <asp:BoundField
                    DataField="Cantidad"
                    HeaderText="Cantidad"/>



                <asp:BoundField
                    DataField="Fecha"
                    HeaderText="Fecha"/>



                <asp:BoundField
                    DataField="Motivo"
                    HeaderText="Motivo"/>





                <asp:TemplateField
                    HeaderText="Acciones">


                <ItemTemplate>




                <asp:Button
                    ID="btnEditar"
                    runat="server"
                    Text="Editar"
                    CssClass="btn btn-sm btn-outline-warning"
                    CommandArgument='<%# Eval("IdMovimiento_Inventario") %>'
                    OnClick="btnEditar_Click"/>





                <asp:Button
                    ID="btnEliminar"
                    runat="server"
                    Text="Eliminar"
                    CssClass="btn btn-sm btn-outline-danger"
                    CommandArgument='<%# Eval("IdMovimiento_Inventario") %>'
                    OnClick="btnEliminar_Click"
                    OnClientClick="return confirm('¿Eliminar movimiento?');"/>



                </ItemTemplate>


                </asp:TemplateField>



                </Columns>



                </asp:GridView>



                </div>



            </div>



        </div>




    </div>




</div>



</asp:Content>