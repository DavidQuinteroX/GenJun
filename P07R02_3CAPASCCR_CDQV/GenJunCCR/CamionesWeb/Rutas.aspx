<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="Rutas.aspx.cs"
Inherits="CamionesWeb.Rutas"
MasterPageFile="~/Site.Master" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="server">
    <link href='<%= ResolveUrl("~/Content/Rutas/Rutas.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
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

    <!-- ================= FORM ================= -->
    <div class="card mb-3">

        <div class="card-header bg-primary text-white">
            Registrar / Editar Ruta
        </div>

        <div class="card-body">

            <asp:HiddenField ID="hfIdRuta" runat="server" />

            <div class="row">

                <div class="col-md-4">
                    <label>Origen</label>
                    <asp:TextBox ID="txtOrigen" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-4">
                    <label>Destino</label>
                    <asp:TextBox ID="txtDestino" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-4">
                    <label>Distancia</label>
                    <asp:TextBox ID="txtDistancia" runat="server" CssClass="form-control" />
                </div>

            </div>

            <div class="row mt-3">

                <div class="col-md-4">
                    <label>Chofer</label>
                    <asp:DropDownList ID="ddlChofer" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-4">
                    <label>Camión</label>
                    <asp:DropDownList ID="ddlCamion" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-2">
                    <label>Salida</label>
                    <asp:TextBox ID="txtSalida" runat="server" TextMode="Date" CssClass="form-control" />
                </div>

                <div class="col-md-2">
                    <label>Llegada</label>
                    <asp:TextBox ID="txtLlegada" runat="server" TextMode="Date" CssClass="form-control" />
                </div>

            </div>

            <div class="mt-3">
                <asp:CheckBox ID="chkATiempo" runat="server" />
                <label>A Tiempo</label>
            </div>

            <div class="mt-3">

                <asp:Button ID="btnGuardar"
                    runat="server"
                    Text="Guardar"
                    CssClass="btn btn-primary"
                    OnClick="btnGuardar_Click" />

                <asp:Button ID="btnActualizar"
                    runat="server"
                    Text="Actualizar"
                    CssClass="btn btn-success"
                    OnClick="btnActualizar_Click" />

                <asp:Button ID="btnCancelar"
                    runat="server"
                    Text="Cancelar"
                    CssClass="btn btn-secondary"
                    OnClick="btnCancelar_Click" />

            </div>

            <asp:Label ID="lblMensaje" runat="server" CssClass="d-block mt-2" />

        </div>
    </div>

    <!-- ================= GRID ================= -->
    <div class="card">

        <div class="card-header bg-dark text-white">
            Listado de Rutas
        </div>

        <div class="card-body">

            <asp:GridView ID="gvRutas"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="table table-bordered table-hover"
                DataKeyNames="IdRuta"
                OnSelectedIndexChanged="gvRutas_SelectedIndexChanged"
                OnRowDeleting="gvRutas_RowDeleting">

                <Columns>

                    <asp:BoundField DataField="IdRuta" HeaderText="ID" />
                    <asp:BoundField DataField="Origen" HeaderText="Origen" />
                    <asp:BoundField DataField="Destino" HeaderText="Destino" />

                    <asp:BoundField DataField="FechaSalida" HeaderText="Salida" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="FechaLlegada" HeaderText="Llegada" DataFormatString="{0:dd/MM/yyyy}" />

                    <asp:BoundField DataField="Distancia" HeaderText="Km" />

                    <asp:BoundField DataField="NombreChofer" HeaderText="Chofer" />
                    <asp:BoundField DataField="Matricula" HeaderText="Camión" />

                    <asp:CheckBoxField DataField="ATiempo" HeaderText="A Tiempo" />

                  
                    <asp:CommandField ShowSelectButton="True" SelectText="Editar" />

                    
                    <asp:CommandField ShowDeleteButton="True" DeleteText="Eliminar" />

                </Columns>

            </asp:GridView>

        </div>

    </div>

</div>

</asp:Content>