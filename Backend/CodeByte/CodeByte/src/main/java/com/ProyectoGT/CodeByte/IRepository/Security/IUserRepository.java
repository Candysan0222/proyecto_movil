package com.ProyectoGT.CodeByte.IRepository.Security;

import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ProyectoGT.CodeByte.DTO.IUserDTO;
import com.ProyectoGT.CodeByte.Entity.Security.User;
import com.ProyectoGT.CodeByte.IRepository.ObjectT.IObjectTRepository;

public interface IUserRepository extends IObjectTRepository<User>{
	
	Optional<User> findByUserName(String userName); // Método para buscar por nombre de usuario

	 @Query("SELECT u.id AS id, u.status AS status, u.createdAt AS createdAt, " +
	           "u.updtatedAt AS updatedAt, u.deletedAt AS deletedAt, " +
	           "u.userName AS userName, u.profilePhoto AS profilePhoto " +
	           "FROM User u WHERE u.id = :id")
	    Optional<IUserDTO> usersDTO(@Param("id") Long id);
}
