<%@ Page Title="Clientes"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Clientes.aspx.cs"
    Inherits="DepsitoWeb.Clientes" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">


<div class="dashboard-container">


    <!-- CABECERA -->

    <div class="dashboard-header">

        <h2>

            <span class="material-icons">
                groups
            </span>

            Clientes

        </h2>

        <p>
            Administración de clientes del depósito
        </p>

    </div>




    <div class="row mt-4">



        <!-- FORMULARIO -->

        <div class="col-lg-4">


            <div class="dashboard-panel">


                <h5>

                    <span class="material-icons">
                        person_add
                    </span>

                    Nuevo Cliente

                </h5>



                <asp:HiddenField
                    ID="hfIdCliente"
                    runat="server" />



                <div class="mb-3">

                    <label class="form-label">
                        Nombre
                    </label>


                    <asp:TextBox
                        ID="txtNombre"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Ingrese nombre">
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

                    Lista de Clientes

                </h5>




                <div class="table-responsive">


                <asp:GridView
                    ID="gvClientes"
                    runat="server"
                    AutoGenerateColumns="false"
                    CssClass="table table-hover align-middle">


                    <Columns>



                    <asp:BoundField
                        DataField="IdCliente"
                        HeaderText="ID" />



                    <asp:BoundField
                        DataField="Nombre"
                        HeaderText="Nombre" />




                    <asp:TemplateField
                        HeaderText="Acciones">


                    <ItemTemplate>


                    <asp:Button
                        ID="btnEditar"
                        runat="server"
                        Text="Editar"
                        CssClass="btn btn-sm btn-outline-warning"
                        CommandArgument='<%# Eval("IdCliente") %>'
                        OnClick="btnEditar_Click" />



                    <asp:Button
                        ID="btnEliminar"
                        runat="server"
                        Text="Eliminar"
                        CssClass="btn btn-sm btn-outline-danger"
                        CommandArgument='<%# Eval("IdCliente") %>'
                        OnClick="btnEliminar_Click"
                        OnClientClick="return confirm('¿Eliminar cliente?');" />


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