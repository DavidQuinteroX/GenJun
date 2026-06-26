<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DepsitoWeb._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <div class="dashboard-container">


        <!-- CABECERA -->

        <div class="dashboard-header d-flex justify-content-between align-items-center">

    <div>
        <h2>
            <span class="material-icons">dashboard</span>
            Dashboard
        </h2>

        <h5>
            <asp:Label ID="lblBienvenida" runat="server" />
        </h5>

        <p>
            <asp:Label ID="lblFecha" runat="server" />
        </p>
    </div>

    <div class="dashboard-clock text-end">

        <span class="material-icons fs-1">
            schedule
        </span>

        <h2 id="horaActual"></h2>

    </div>

</div>



        <!-- CARDS -->


        <div class="row g-4 mt-3">


            <!-- PRODUCTOS -->

            <div class="col-xl-3 col-md-6">


                <div class="dashboard-card">


                    <div class="card-icon">

                        <span class="material-icons">inventory_2
                    </span>

                    </div>


                    <div>

                        <small>Productos
                    </small>


                        <h2>
                            <asp:Label
                                ID="lblProductos"
                                runat="server" />
                        </h2>

                    </div>


                </div>


            </div>





            <!-- CLIENTES -->

            <div class="col-xl-3 col-md-6">


                <div class="dashboard-card">


                    <div class="card-icon">

                        <span class="material-icons">groups
                    </span>

                    </div>


                    <div>

                        <small>Clientes
                    </small>


                        <h2>
                            <asp:Label
                                ID="lblClientes"
                                runat="server" />
                        </h2>

                    </div>


                </div>


            </div>





            <!-- VENTAS -->

            <div class="col-xl-3 col-md-6">


                <div class="dashboard-card">


                    <div class="card-icon">

                        <span class="material-icons">point_of_sale
                    </span>

                    </div>


                    <div>

                        <small>Ventas
                    </small>


                        <h2>
                            <asp:Label
                                ID="lblVentas"
                                runat="server" />
                        </h2>

                    </div>


                </div>


            </div>





            <!-- INVENTARIO -->

            <div class="col-xl-3 col-md-6">


                <div class="dashboard-card">


                    <div class="card-icon">

                        <span class="material-icons">warehouse
                    </span>

                    </div>


                    <div>

                        <small>Inventario
                    </small>


                        <h2>
                            <asp:Label
                                ID="lblInventario"
                                runat="server" />
                        </h2>

                    </div>


                </div>


            </div>



        </div>





        <!-- SEGUNDA ZONA -->


        <div class="row mt-4">


            <!-- GRAFICO -->


            <div class="col-lg-8">


                <div class="dashboard-panel">


                    <h5>

                        <span class="material-icons">monitoring
                    </span>

                        Ventas mensuales

                </h5>


                    <canvas id="ventasChart"
                        height="120"></canvas>


                </div>


            </div>




            <!-- ALERTAS -->


            <div class="col-lg-4">


                <div class="dashboard-panel">


                    <h5>

                        <span class="material-icons">notifications
                    </span>

                        Alertas

                </h5>



                    <div class="alert alert-warning">
                        Sin alertas

               
                    </div>


                </div>


            </div>



        </div>




    </div>


    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


    <script>


        const ctx =
            document.getElementById('ventasChart');


        new Chart(ctx, {


            type: 'line',


            data: {


                labels: [
                    'Ene',
                    'Feb',
                    'Mar',
                    'Abr',
                    'May',
                    'Jun'
                ],


                datasets: [{


                    label: 'Ventas',


                    data: [
                        10,
                        25,
                        18,
                        40,
                        35,
                        60
                    ],


                    borderColor: '#F9A826',


                    backgroundColor: 'rgba(249,168,38,.2)',


                    fill: true,


                    tension: .4


                }]


            },



            options: {


                responsive: true,


                plugins: {


                    legend: {


                        display: false


                    }


                }


            }



        });


</script>
    <script>
        function actualizarReloj() {

            const ahora = new Date();

            const hora = ahora.toLocaleTimeString('es-MX', {
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });

            document.getElementById("horaActual").innerHTML = hora;
        }

        setInterval(actualizarReloj, 1000);

        actualizarReloj();
    </script>

</asp:Content>
