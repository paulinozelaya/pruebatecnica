using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PruebaTecnicaPaulinoZelaya_Api.Models;
using System.Data.SqlClient;

namespace PruebaTecnicaPaulinoZelaya_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AsignacionController : ControllerBase
    {
        private readonly string _connectionString;

        public AsignacionController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Asignacion>>> GetAsignaciones()
        {
            var asignaciones = new List<Asignacion>();

            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    await connection.OpenAsync();

                    using (SqlCommand command = new SqlCommand("prAsignarSaldosAGestores", connection))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;

                        using (SqlDataReader reader = await command.ExecuteReaderAsync())
                        {
                            while (await reader.ReadAsync())
                            {
                                var asignacion = new Asignacion
                                {
                                    AsignacionID = reader.GetInt32(0),
                                    Gestor = reader.GetString(1),
                                    Saldo = reader.GetInt32(2)
                                };

                                asignaciones.Add(asignacion);
                            }
                        }
                    }
                }

                return Ok(asignaciones);
            }
            catch (Exception ex)
            {
                // Log the detailed exception
                Console.Error.WriteLine(ex.Message);
                return StatusCode(500, "An unexpected error occurred.");
            }
        }
    }

}
