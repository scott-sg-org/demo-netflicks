using DotNetFlicks.Accessors.Models.DTO.Base;

namespace DotNetFlicks.Accessors.Models.DTO
{
    public class UserSearchesDTO : EntityDTO
    {
        public string UserId { get; set; }

        public string SearchTerm {get; set;}
    }
}
