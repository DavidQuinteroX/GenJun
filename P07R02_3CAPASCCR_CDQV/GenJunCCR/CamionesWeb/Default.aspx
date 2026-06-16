<%--<%@ <%--Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CamionesWeb._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <section class="row" aria-labelledby="aspnetTitle">
            <h1 id="aspnetTitle">ASP.NET</h1>
            <p class="lead">ASP.NET is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
            <p><a href="http://www.asp.net" class="btn btn-primary btn-md">Learn more &raquo;</a></p>
        </section>

        <div class="row">
            <section class="col-md-4" aria-labelledby="gettingStartedTitle">
                <h2 id="gettingStartedTitle">Getting started</h2>
                <p>
                    ASP.NET Web Forms lets you build dynamic websites using a familiar drag-and-drop, event-driven model.
                A design surface and hundreds of controls and components let you rapidly build sophisticated, powerful UI-driven sites with data access.
                </p>
                <p>
                    <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301948">Learn more &raquo;</a>
                </p>
            </section>
            <section class="col-md-4" aria-labelledby="librariesTitle">
                <h2 id="librariesTitle">Get more libraries</h2>
                <p>
                    NuGet is a free Visual Studio extension that makes it easy to add, remove, and update libraries and tools in Visual Studio projects.
                </p>
                <p>
                    <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301949">Learn more &raquo;</a>
                </p>
            </section>
            <section class="col-md-4" aria-labelledby="hostingTitle">
                <h2 id="hostingTitle">Web Hosting</h2>
                <p>
                    You can easily find a web hosting company that offers the right mix of features and price for your applications.
                </p>
                <p>
                    <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301950">Learn more &raquo;</a>
                </p>
            </section>
        </div>
    </main>

</asp:Content>--%>


<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master"
AutoEventWireup="true" CodeBehind="Default.aspx.cs"
Inherits="CamionesWeb._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

   <!-- HERO -->
<header class="hero" id="inicio">
  <div class="hero-content">
    <div class="hero-badge fade-in delay-1">
      <i class="fa-solid fa-bolt"></i>
      Plataforma Inteligente de Logística
    </div>

    <h1 class="slide-up delay-2">
      Control Total de tu <br class="d-none d-md-block" />
      Operación de Transporte
    </h1>

    <p class="lead slide-up delay-3">
      Administra camiones, conductores y rutas desde una sola plataforma.
      Optimiza tu flota, reduce costos y toma mejores decisiones con información en tiempo real.
    </p>

    <div class="hero-cta slide-up delay-4">
      <a href="#camiones" class="btn btn-hero btn-primary-hero">
        <i class="fa-solid fa-gears"></i> Gestionar Operación
      </a>
      <a href="#reportes" class="btn btn-hero btn-outline-hero">
        <i class="fa-solid fa-chart-line"></i> Ver Reportes
      </a>
    </div>

    <div class="hero-stats slide-up delay-5">
      <div class="stat">
        <span class="num" data-target="500">0</span>
        <span class="lbl">Camiones</span>
      </div>
      <div class="stat">
        <span class="num" data-target="1200">0</span>
        <span class="lbl">Conductores</span>
      </div>
      <div class="stat">
        <span class="num" data-target="98">0</span>
        <span class="lbl">% Eficiencia</span>
      </div>
      <div class="stat">
        <span class="num" data-target="24">0</span>
        <span class="lbl">Monitoreo 24/7</span>
      </div>
    </div>
  </div>


</header>

   

</asp:Content>