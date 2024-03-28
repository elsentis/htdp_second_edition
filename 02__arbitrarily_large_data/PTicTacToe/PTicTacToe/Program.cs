using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

// Разработать игру Крестики-Нолики используя оконный интерфейс.
// В проекте должно быть два класса - класс формы и класс, реализующий логику игры.
// Предварительно скачайте архив проекта...

namespace PTicTacToe
{
    static class Program
    {
        /// <summary>
        /// Главная точка входа для приложения.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1());
        }
    }

    public class GameLogic
    {
        // Инициализация двумерного массива для хранения значения состояния каждой
        // клетки игрового поля
        
        public char[,] m = new char[,]
            {
                {' ', ' ', ' ' },
                {' ', ' ', ' ' },
                {' ', ' ', ' ' }
            };
    }
}

    
