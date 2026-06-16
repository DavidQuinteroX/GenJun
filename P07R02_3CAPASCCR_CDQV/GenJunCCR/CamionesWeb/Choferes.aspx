<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="Choferes.aspx.cs"
Inherits="CamionesWeb.Choferes"
MasterPageFile="~/Site.Master" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="server">
    <link href='<%= ResolveUrl("~/Content/Choferes/Choferes.css") %>' rel="stylesheet" />
    
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="choferes-page">

    <div class="container-fluid py-4">

        <!-- ================= HEADER ================= -->
        <header class="app-header">
            <div class="d-flex justify-content-between align-items-center px-4">

                <div class="d-flex align-items-center gap-3">
                    <div class="header-icon">🚛</div>
                    <div>
                        <div class="header-title">Gestión de Choferes</div>
                        <div class="header-subtitle">Administración de personal operativo</div>
                    </div>
                </div>

                <div class="system-status">
                    <span class="status-dot"></span>
                    Sistema Activo
                    <span class="status-time" id="time"></span>
                </div>

            </div>
        </header>

    <div class="card-body">
                    <div class="mb-3">
                        <asp:Button ID="btnNuevo"
                            runat="server"
                            Text="Nuevo Chofer"
                            CssClass="btn btn-success"
                            OnClick="btnNuevo_Click" />
                    </div>

                    <asp:Panel ID="pnlChofer" runat="server" Visible="false">
                        <asp:HiddenField ID="hfIdChofer" runat="server" />
                        <div class="card mb-4">
                            <div class="card-header bg-success text-white">
                                Registrar Chofer
                            </div>

                            <div class="card-body">

                                <asp:Label ID="lblMensaje" runat="server"></asp:Label>

                                <div class="row">

                                    <div class="col-md-4">
                                        <label>Nombre</label>
                                        <asp:TextBox ID="txtNombre" runat="server"
                                            CssClass="form-control"></asp:TextBox>
                                    </div>

                                    <div class="col-md-4">
                                        <label>Apellido Paterno</label>
                                        <asp:TextBox ID="txtApPaterno" runat="server"
                                            CssClass="form-control"></asp:TextBox>
                                    </div>

                                    <div class="col-md-4">
                                        <label>Apellido Materno</label>
                                        <asp:TextBox ID="txtApMaterno" runat="server"
                                            CssClass="form-control"></asp:TextBox>
                                    </div>

                                </div>

                                <div class="row mt-3">

                                    <div class="col-md-4">
                                        <label>Teléfono</label>
                                        <asp:TextBox ID="txtTelefono" runat="server"
                                            CssClass="form-control"></asp:TextBox>
                                    </div>

                                    <div class="col-md-4">
                                        <label>Fecha Nacimiento</label>
                                        <asp:TextBox ID="txtFechaNacimiento"
                                            runat="server"
                                            TextMode="Date"
                                            CssClass="form-control">
                                        </asp:TextBox>
                                    </div>

                                    <div class="col-md-4">
                                        <label>Licencia</label>
                                        <asp:TextBox ID="txtLicencia" runat="server"
                                            CssClass="form-control"></asp:TextBox>
                                    </div>

                                </div>

                                <div class="row mt-3">

                                    <div class="col-md-6">
                                        <label>URL Foto</label>
                                        <asp:TextBox ID="txtUrlFoto" runat="server"
                                            CssClass="form-control"></asp:TextBox>
                                    </div>

                                    <div class="col-md-4">
                                        <label>Disponible</label>
                                        <br />
                                        <asp:CheckBox ID="chkDisponibilidad"
                                            runat="server"
                                            Checked="true" />
                                    </div>

                                </div>

                                <div class="mt-3">

                                    <asp:Button ID="btnGuardar"
                                        runat="server"
                                        Text="Guardar"
                                        CssClass="btn btn-primary"
                                        OnClick="btnGuardar_Click" />

                                    <asp:Button ID="btnCancelar"
                                        runat="server"
                                        Text="Cancelar"
                                        CssClass="btn btn-secondary"
                                        OnClick="btnCancelar_Click" />

                                </div>

                            </div>

                        </div>

                    </asp:Panel>
                    <asp:GridView ID="gvChoferes"
                        runat="server"
                        AutoGenerateColumns="False"
                        CssClass="table table-bordered table-hover">

                        <Columns>

                            <asp:BoundField DataField="IdChofer"
                                HeaderText="ID" />

                            <asp:BoundField DataField="NombreCompleto"
                                HeaderText="Nombre Completo" />

                            <asp:BoundField DataField="Telefono"
                                HeaderText="Teléfono" />
                            <asp:BoundField DataField="FechaNacimiento"
                                HeaderText="Fecha de Nacimiento"
                                DataFormatString="{0:dd/MM/yyyy}" />

                            <asp:BoundField DataField="Licencia"
                                HeaderText="Licencia" />

                            <asp:BoundField DataField="UrlFoto"
                                HeaderText="UrlFoto" />

                            <asp:TemplateField HeaderText="Estado">
                                <ItemTemplate>

                                    <asp:Label ID="lblEstado"
                                        runat="server"
                                        Text='<%# Convert.ToBoolean(Eval("Disponibilidad")) ? "Disponible" : "No Disponible" %>'
                                        CssClass='<%# Convert.ToBoolean(Eval("Disponibilidad")) ? "badge bg-success" : "badge bg-danger" %>'>
                                    </asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:BoundField DataField="FechaRegistro"
                                HeaderText="Fecha Registro"
                                DataFormatString="{0:dd/MM/yyyy}" />


                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <asp:Button ID="btnEditar"
                                        runat="server"
                                        Text="Editar"
                                        CssClass="btn btn-warning btn-sm"
                                        CommandArgument='<%# Eval("IdChofer") %>'
                                        OnClick="btnEditar_Click" />
                                    <asp:Button ID="btnEliminar"
                                        runat="server"
                                        Text="Eliminar"
                                        CssClass="btn btn-danger btn-sm"
                                        CommandArgument='<%# Eval("IdChofer") %>'
                                        OnClick="btnEliminar_Click"
                                        OnClientClick="return confirm('¿Deseas eliminar este chofer?');" />
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>

                    </asp:GridView>

                </div>

            </div>
        </div>

    

</asp:Content>