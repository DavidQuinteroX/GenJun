<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Camiones.aspx.cs"
    Inherits="CamionesWeb.Camiones"
    MasterPageFile="~/Site.Master" %>

<asp:Content
    ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <link href="/Content/Camiones/Camiones.css" rel="stylesheet" />



        <%--       <!-- HEADER -->
        <header class="app-header">
            <div class="header-brand">
                <div class="header-icon">🚛</div>
                <div class="header-text">
                    <h1>Gestión de Camiones</h1>
                    <p>Administración de Flota</p>
                </div>
            </div>
            <div class="header-meta">
                <span class="status-dot"></span>
                Sistema operativo
            </div>
        </header>--%>
        <!-- ===================== HEADER ===================== -->
<header class="app-header">
  <div class="container-fluid">
    <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
      <div class="d-flex align-items-center gap-3">
        <div class="header-icon">
          <i class="fa-solid fa-id-card-clip"></i>
        </div>
        <div>
          <h1 class="header-title mb-0">Gestión de Choferes</h1>
          <p class="header-subtitle mb-0">Administración de Flota</p>
        </div>
      </div>
      <div class="system-status">
        <span class="status-dot"></span>
        <span>Sistema Operativo</span>
        <span class="status-time" id="systemTime">--:--:--</span>
      </div>
    </div>
  </div>
</header>

<main class="app-shell">
    

        <!-- KPIs -->
        <section class="kpi-grid">
            <div class="kpi-card">
                <div class="kpi-icon blue">🚚</div>
                <div class="kpi-body">
                    <div class="kpi-label">Total Camiones</div>
                    <div class="kpi-value" id="kpiTotal">0</div>
                    <div class="kpi-trend">Flota completa</div>
                </div>
            </div>
            <div class="kpi-card">
                <div class="kpi-icon green">✅</div>
                <div class="kpi-body">
                    <div class="kpi-label">Disponibles</div>
                    <div class="kpi-value" id="kpiDisp">0</div>
                    <div class="kpi-trend">Listos para operar</div>
                </div>
            </div>
            <div class="kpi-card">
                <div class="kpi-icon red">⛔</div>
                <div class="kpi-body">
                    <div class="kpi-label">No Disponibles</div>
                    <div class="kpi-value" id="kpiNoDisp">0</div>
                    <div class="kpi-trend">En servicio / taller</div>
                </div>
            </div>
            <div class="kpi-card">
                <div class="kpi-icon purple">📦</div>
                <div class="kpi-body">
                    <div class="kpi-label">Capacidad Total</div>
                    <div class="kpi-value" id="kpiCap">0</div>
                    <div class="kpi-trend">Toneladas</div>
                </div>
            </div>
        </section>

        <!-- MAIN CARD -->
        <div class="card">

            <!-- ACTION BAR -->
            <div class="action-bar">
                <div class="filter-group">
                    <span class="filter-label">Filtro</span>
                    <asp:DropDownList ID="ddlFiltro" runat="server">
                        <asp:ListItem Value=" ">Todos los camiones</asp:ListItem>
                        <asp:ListItem Value="1">Disponibles</asp:ListItem>
                        <asp:ListItem Value="0">No Disponibles</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="quick-search">
                    <input type="text" id="txtBusqueda" placeholder="Buscar camión..." onkeyup="filtrarTabla()" />
                </div>

                <div class="action-spacer"></div>

                <div class="action-actions">
                    <button type="button" class="btn btn-new" onclick="abrirModal()">➕ Nuevo Camión</button>
                    <span class="btn-wrap search">
                        <asp:Button ID="btnFiltrar" runat="server" Text="     Buscar" OnClick="btnFiltrar_Click" />
                    </span>
                    <span class="btn-wrap refresh">
                        <asp:Button ID="btnActualizar" runat="server" Text="     Actualizar" OnClick="btnActualizar_Click" />
                    </span>
                </div>
            </div>

            <!-- MENSAJE -->
            <asp:Panel ID="pnlMensaje" runat="server" CssClass="info-mensaje info" Visible="false">
                <asp:Label ID="lblMensaje" runat="server" Text=""></asp:Label>
            </asp:Panel>

            <!-- TABLE -->
            <div class="table-wrap">
                <div class="table-meta">
                    <div class="table-title">Flota de camiones</div>
                    <div class="table-sub">Listado en tiempo real</div>
                </div>

                <asp:GridView ID="gvCamiones" runat="server"
                    AutoGenerateColumns="False"
                    CssClass="gridview"
                    GridLines="None"
                    OnRowCommand="gvCamiones_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="IdCamion" HeaderText="ID" />
                        <asp:BoundField DataField="Matricula" HeaderText="Matrícula" />
                        <asp:BoundField DataField="TipoCamion" HeaderText="Tipo" />
                        <asp:BoundField DataField="Marca" HeaderText="Marca" />
                        <asp:BoundField DataField="Modelo" HeaderText="Modelo" />
                        <asp:BoundField DataField="Capacidad" HeaderText="Capacidad" />
                        <asp:BoundField DataField="Kilometraje" HeaderText="Kilometraje" />
                        <asp:TemplateField HeaderText="Disponibilidad">
                            <ItemTemplate>
                                <span class='<%# (bool)Eval("Disponibilidad") ? "badge badge-success" : "badge badge-danger" %>'>
                                    <%# (bool)Eval("Disponibilidad") ? "Disponible" : "No Disponible" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>

                                <asp:LinkButton
                                    ID="btnEditar"
                                    runat="server"
                                    Text="✏️ Editar"
                                    CommandName="Editar"
                                    CommandArgument='<%# Eval("IdCamion") %>'
                                    CssClass="btn btn-warning" />

                                &nbsp;

       

                                <asp:LinkButton
                                    ID="btnEliminar"
                                    runat="server"
                                    Text="🗑️ Eliminar"
                                    CommandName="Eliminar"
                                    CommandArgument='<%# Eval("IdCamion") %>'
                                    OnClientClick="return confirm('¿Desea eliminar este camión?');"
                                    CssClass="btn btn-danger" />

                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
 


    <section class="kpi-grid">...</section>

    
</main>

            <!-- TODO tu contenido -->

    <!-- MODAL NUEVO CAMIÓN (solo visual) -->
<div class="cm-backdrop" id="modalCamion" onclick="if(event.target===this)cerrarModal()">
    <div class="cm-modal" role="dialog" aria-modal="true">
        <div class="modal-header">
            <h3>Nuevo Camión</h3>
            <button type="button" class="modal-close" onclick="cerrarModal()" aria-label="Cerrar">✕</button>
        </div>
        <div class="modal-body">
            <div class="form-grid">
                <!--Matricula-->
                <div class="form-field">
                    <label>Matrícula</label>
                    <asp:TextBox ID="txtMatricula" runat="server"></asp:TextBox>
                </div>

                <div class="form-field">
                    <label>Tipo</label>
                    <asp:TextBox ID="txtTipo" runat="server"></asp:TextBox>
                </div>

                <div class="form-field">
                    <label>Marca</label>
                    <asp:TextBox ID="txtMarca" runat="server"></asp:TextBox>
                </div>

                <div class="form-field">
                    <label>Año Modelo</label>
                    <asp:TextBox ID="txtModelo" runat="server" TextMode="Number"></asp:TextBox>
                </div>

                <div class="form-field">
                    <label>Capacidad</label>
                    <asp:TextBox ID="txtCapacidad" runat="server" TextMode="Number"></asp:TextBox>
                </div>

                <div class="form-field">
                    <label>Kilometraje</label>
                    <asp:TextBox ID="txtKilometraje" runat="server" TextMode="Number"></asp:TextBox>
                </div>

                <div class="form-field full">
                    <label>Disponibilidad</label>
                    <asp:DropDownList ID="ddlDisponibilidad" runat="server">
                        <asp:ListItem Value="true">Disponible</asp:ListItem>
                        <asp:ListItem Value="false">No Disponible</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="form-field full">
                    <label>URL Foto</label>
                    <asp:TextBox ID="txtUrlFoto" runat="server"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-ghost" onclick="cerrarModal()">
                Cancelar
            </button>

            <asp:Button
                ID="btnGuardarCamion"
                runat="server"
                Text="💾 Guardar"
                CssClass="btn btn-primary"
                OnClick="btnGuardarCamion_Click" />
        </div>
    </div>
</div>

           

    <script type="text/javascript">
        // MODAL
        function abrirModal() {
            document.getElementById('modalCamion').classList.add('open');
            document.body.style.overflow = 'hidden';
        }
        function cerrarModal() {
            document.getElementById('modalCamion').classList.remove('open');
            document.body.style.overflow = '';
        }
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') cerrarModal();
        });

        // BÚSQUEDA RÁPIDA (filtrado visual en cliente)
        function filtrarTabla() {
            var q = (document.form1getElementById('txtBusqueda').value || '').toLowerCase();
            var grid = document.getElementById('<%= gvCamiones.ClientID %>');
            if (!grid) return;
            var rows = grid.getElementsByTagName('tr');
            for (var i = 1; i < rows.length; i++) {
                var txt = rows[i].innerText.toLowerCase();
                rows[i].style.display = txt.indexOf(q) > -1 ? '' : 'none';
            }
        }

        // KPIs + ORDENAMIENTO VISUAL
        (function () {
            var grid = document.getElementById('<%= gvCamiones.ClientID %>');
            if (!grid) return;

            // KPIs
            var rows = grid.querySelectorAll('tr');
            var total = 0, disp = 0, nodisp = 0, cap = 0;
            for (var i = 1; i < rows.length; i++) {
                var cells = rows[i].getElementsByTagName('td');
                if (!cells.length) continue;
                total++;
                var capVal = parseFloat((cells[5] && cells[5].innerText || '0').replace(',', '.')) || 0;
                cap += capVal;
                var estado = (cells[7] && cells[7].innerText || '').toLowerCase();
                if (estado.indexOf('no') === -1 && estado.indexOf('disponible') !== -1) disp++;
                else if (estado.indexOf('no') !== -1) nodisp++;
            }
            document.getElementById('kpiTotal').innerText = total;
            document.getElementById('kpiDisp').innerText = disp;
            document.getElementById('kpiNoDisp').innerText = nodisp;
            document.getElementById('kpiCap').innerText = cap.toLocaleString();

            // ORDENAMIENTO VISUAL
            var headers = grid.querySelectorAll('th');
            headers.forEach(function (th, idx) {
                var ico = document.createElement('span');
                ico.className = 'sort-ico';
                ico.textContent = '▲▼';
                th.appendChild(ico);
                var dir = 1;
                th.addEventListener('click', function () {
                    headers.forEach(function (h) { h.classList.remove('sort-asc', 'sort-desc'); });
                    th.classList.add(dir === 1 ? 'sort-asc' : 'sort-desc');
                    th.querySelector('.sort-ico').textContent = dir === 1 ? '▲' : '▼';
                    var tbody = grid.querySelector('tbody') || grid;
                    var rs = Array.prototype.slice.call(tbody.querySelectorAll('tr')).filter(function (r) {
                        return r.getElementsByTagName('td').length > 0;
                    });
                    rs.sort(function (a, b) {
                        var x = a.getElementsByTagName('td')[idx].innerText.trim();
                        var y = b.getElementsByTagName('td')[idx].innerText.trim();
                        var nx = parseFloat(x.replace(',', '.')), ny = parseFloat(y.replace(',', '.'));
                        if (!isNaN(nx) && !isNaN(ny)) return (nx - ny) * dir;
                        return x.localeCompare(y) * dir;
                    });
                    rs.forEach(function (r) { tbody.appendChild(r); });
                    dir = -dir;
                });
            });
        })();
    </script>


</asp:Content>

