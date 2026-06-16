<%@ Page Title="Contacto - David Quintero"
Language="C#"
MasterPageFile="~/Site.Master"
AutoEventWireup="true"
CodeBehind="Contact.aspx.cs"
Inherits="CamionesWeb.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<div class="container py-5">

    <!-- ================= HEADER ================= -->
    <div class="text-center mb-5">

        <h1>👨‍💻 David Quintero</h1>

        <h4 class="text-muted">
            Desarrollador Full Stack .NET Core | ASP.NET Framework | Entity Framework
        </h4>

        <p class="mt-3">
            Construyendo sistemas escalables, eficientes y modernos con arquitectura en capas.
        </p>

    </div>

    <!-- ================= CARDS ================= -->
    <div class="row text-center">

        <!-- GITHUB -->
        <div class="col-md-4 mb-3">
            <div class="card shadow-sm p-4">

                <h2>🐙 GitHub</h2>
                <p>Revisa mis proyectos y código fuente</p>

                <a href="https://github.com/TU_USUARIO"
                   target="_blank"
                   class="btn btn-dark">
                    <i class="bi bi-github"></i> Ir a GitHub
                </a>

            </div>
        </div>

        <!-- LINKEDIN -->
        <div class="col-md-4 mb-3">
            <div class="card shadow-sm p-4">

                <h2>💼 LinkedIn</h2>
                <p>Conecta conmigo profesionalmente</p>

                <a href="https://linkedin.com/in/TU_USUARIO"
                   target="_blank"
                   class="btn btn-primary">
                    <i class="bi bi-linkedin"></i> Ver Perfil
                </a>

            </div>
        </div>

        <!-- EMAIL -->
        <div class="col-md-4 mb-3">
            <div class="card shadow-sm p-4">

                <h2>📧 Contacto</h2>
                <p>Envíame un correo directo</p>

                <a href="mailto:davidquintero@email.com"
                   class="btn btn-success">
                    ✉ Enviar Email
                </a>

            </div>
        </div>

    </div>

    <!-- ================= SKILLS ================= -->
    <div class="mt-5 text-center">

        <h3>⚙ Tecnologías</h3>

        <span class="badge bg-primary m-1">ASP.NET</span>
        <span class="badge bg-secondary m-1">.NET Core</span>
        <span class="badge bg-success m-1">Entity Framework</span>
        <span class="badge bg-danger m-1">SQL Server</span>
        <span class="badge bg-warning text-dark m-1">C#</span>
        <span class="badge bg-dark m-1">WebForms</span>

    </div>

</div>

</asp:Content>