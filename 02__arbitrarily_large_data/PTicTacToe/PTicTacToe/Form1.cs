using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PTicTacToe
{
    public partial class Form1 : Form
    {
        // размер кнопки
        private const int butsize = 70;
        // чей ход? =true, если крестика
        private bool player = true;

        public Form1()
        {
            InitializeComponent();
        }

       

        private void btnStart_Click(object sender, EventArgs e)
        {
            lblStatus.Text = "Ход 1 Игрока";

            List<System.Windows.Forms.Button> list_of_buttons ;
            list_of_buttons = this.tableLayoutPanel1.Controls.OfType<Button>().ToList();

            foreach (Button button in list_of_buttons)
                button.BackColor = Color.Silver;
        }

        private void btnHelp_Click(object sender, EventArgs e)
        {

        }

        

        private void button_Click(object sender, EventArgs e)
        {
            Button clickedButton = sender as Button;

            int row = Convert.ToInt32(clickedButton.TabIndex / 3);
            int column = Convert.ToInt32(clickedButton.TabIndex % 3);

            if (player)
                GameLogic.m[row, column] = 'x';
        }

        private void j(object sender, EventArgs e)
        {
             
                    
        }
    }
   
}
