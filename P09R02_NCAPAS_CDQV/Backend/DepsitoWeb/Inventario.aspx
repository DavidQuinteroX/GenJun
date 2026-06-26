<%@ Page Title="Inventario"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Inventario.aspx.cs"
    Inherits="DepsitoWeb.Inventario" %>



<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">



<div class="dashboard-container">



    <!-- CABECERA -->

    <div class="dashboard-header">


        <h2>

            <span class="material-icons">
                warehouse
            </span>

            Inventario

        </h2>


        <p>
            Control de existencias del depósito
        </p>


    </div>






    <asp:HiddenField
        ID="hfIdInventario"
        runat="server" />






    <div class="row mt-4">





        <!-- FORMULARIO -->


        <div class="col-lg-4">


            <div class="dashboard-panel">



                <h5>

                    <span class="material-icons">
                        inventory_2
                    </span>

                    Actualizar Stock

                </h5>





                <div class="mb-3">


                    <label class="form-label">
                        Presentación
                    </label>



                    <asp:DropDownList
                        ID="ddlPresentacion"
                        runat="server"
                        CssClass="form-select">
                    </asp:DropDownList>


                </div>





                <div class="mb-3">


                    <label class="form-label">
                        Existencia
                    </label>



                    <asp:TextBox
                        ID="txtExistencia"
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
                        ID="btnActualizar"
                        runat="server"
                        Text="Actualizar"
                        CssClass="btn btn-primary"
                        OnClick="btnActualizar_Click"
                        Visible="false" />


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


                    Stock disponible


                </h5>






                <div class="table-responsive">



                <asp:GridView
                    ID="gvInventario"
                    runat="server"
                    CssClass="table table-hover align-middle"
                    AutoGenerateColumns="False"
                    OnRowCommand="gvInventario_RowCommand">





                <Columns>





                <asp:BoundField
                    DataField="IdInventario"
                    HeaderText="ID" />





                <asp:BoundField
                    DataField="Producto"
                    HeaderText="Producto" />





                <asp:BoundField
                    DataField="Marca"
                    HeaderText="Marca" />





                <asp:BoundField
                    DataField="Presentacion"
                    HeaderText="Presentación" />





                <asp:BoundField
                    DataField="Existencia"
                    HeaderText="Stock" />







                <asp:TemplateField
                    HeaderText="Acciones">



                <ItemTemplate>





                    <asp:Button
                        ID="btnEditar"
                        runat="server"
                        Text="Editar"
                        CssClass="btn btn-sm btn-outline-warning"
                        CommandName="Editar"
                        CommandArgument='<%# Eval("IdInventario") %>' />





                    <asp:Button
                        ID="btnEliminar"
                        runat="server"
                        Text="Eliminar"
                        CssClass="btn btn-sm btn-outline-danger"
                        CommandName="Eliminar"
                        CommandArgument='<%# Eval("IdInventario") %>' />





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