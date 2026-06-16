namespace CapaWindowsForms
{
    partial class Form1
    {
        /// <summary>
        /// Variable del diseñador necesaria.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén usando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben desechar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido de este método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.Label = new System.Windows.Forms.Label();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabCamiones = new System.Windows.Forms.TabPage();
            this.dgvCamiones = new System.Windows.Forms.DataGridView();
            this.tabChoferes = new System.Windows.Forms.TabPage();
            this.dgvChoferes = new System.Windows.Forms.DataGridView();
            this.tabRutas = new System.Windows.Forms.TabPage();
            this.dgvRutas = new System.Windows.Forms.DataGridView();
            this.tabControl1.SuspendLayout();
            this.tabCamiones.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvCamiones)).BeginInit();
            this.tabChoferes.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvChoferes)).BeginInit();
            this.tabRutas.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvRutas)).BeginInit();
            this.SuspendLayout();
            // 
            // Label
            // 
            this.Label.AutoSize = true;
            this.Label.Font = new System.Drawing.Font("Arial", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Label.Location = new System.Drawing.Point(299, 9);
            this.Label.Name = "Label";
            this.Label.Size = new System.Drawing.Size(164, 23);
            this.Label.TabIndex = 0;
            this.Label.Text = "Cargar Camiones";
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabCamiones);
            this.tabControl1.Controls.Add(this.tabChoferes);
            this.tabControl1.Controls.Add(this.tabRutas);
            this.tabControl1.Location = new System.Drawing.Point(29, 60);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(728, 312);
            this.tabControl1.TabIndex = 1;
            this.tabControl1.SelectedIndexChanged += new System.EventHandler(this.tabControl1_SelectedIndexChanged);
            // 
            // tabCamiones
            // 
            this.tabCamiones.Controls.Add(this.dgvCamiones);
            this.tabCamiones.Location = new System.Drawing.Point(4, 29);
            this.tabCamiones.Name = "tabCamiones";
            this.tabCamiones.Padding = new System.Windows.Forms.Padding(3);
            this.tabCamiones.Size = new System.Drawing.Size(720, 279);
            this.tabCamiones.TabIndex = 0;
            this.tabCamiones.Text = "Camiones";
            this.tabCamiones.UseVisualStyleBackColor = true;
            // 
            // dgvCamiones
            // 
            this.dgvCamiones.BackgroundColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.dgvCamiones.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvCamiones.Location = new System.Drawing.Point(23, 17);
            this.dgvCamiones.Name = "dgvCamiones";
            this.dgvCamiones.RowHeadersWidth = 62;
            this.dgvCamiones.RowTemplate.Height = 28;
            this.dgvCamiones.Size = new System.Drawing.Size(675, 237);
            this.dgvCamiones.TabIndex = 0;
            // 
            // tabChoferes
            // 
            this.tabChoferes.Controls.Add(this.dgvChoferes);
            this.tabChoferes.Location = new System.Drawing.Point(4, 29);
            this.tabChoferes.Name = "tabChoferes";
            this.tabChoferes.Padding = new System.Windows.Forms.Padding(3);
            this.tabChoferes.Size = new System.Drawing.Size(720, 279);
            this.tabChoferes.TabIndex = 1;
            this.tabChoferes.Text = "Choferes";
            this.tabChoferes.UseVisualStyleBackColor = true;
            // 
            // dgvChoferes
            // 
            this.dgvChoferes.BackgroundColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.dgvChoferes.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvChoferes.Location = new System.Drawing.Point(2, 3);
            this.dgvChoferes.Name = "dgvChoferes";
            this.dgvChoferes.RowHeadersWidth = 62;
            this.dgvChoferes.RowTemplate.Height = 28;
            this.dgvChoferes.Size = new System.Drawing.Size(717, 263);
            this.dgvChoferes.TabIndex = 0;
            // 
            // tabRutas
            // 
            this.tabRutas.Controls.Add(this.dgvRutas);
            this.tabRutas.Location = new System.Drawing.Point(4, 29);
            this.tabRutas.Name = "tabRutas";
            this.tabRutas.Size = new System.Drawing.Size(720, 279);
            this.tabRutas.TabIndex = 2;
            this.tabRutas.Text = "Rutas";
            this.tabRutas.UseVisualStyleBackColor = true;
            // 
            // dgvRutas
            // 
            this.dgvRutas.BackgroundColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.dgvRutas.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvRutas.Location = new System.Drawing.Point(3, 7);
            this.dgvRutas.Name = "dgvRutas";
            this.dgvRutas.RowHeadersWidth = 62;
            this.dgvRutas.RowTemplate.Height = 28;
            this.dgvRutas.Size = new System.Drawing.Size(716, 271);
            this.dgvRutas.TabIndex = 0;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.tabControl1);
            this.Controls.Add(this.Label);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.tabControl1.ResumeLayout(false);
            this.tabCamiones.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvCamiones)).EndInit();
            this.tabChoferes.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvChoferes)).EndInit();
            this.tabRutas.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvRutas)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label Label;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabCamiones;
        private System.Windows.Forms.TabPage tabChoferes;
        private System.Windows.Forms.DataGridView dgvCamiones;
        private System.Windows.Forms.TabPage tabRutas;
        private System.Windows.Forms.DataGridView dgvChoferes;
        private System.Windows.Forms.DataGridView dgvRutas;
    }
}

