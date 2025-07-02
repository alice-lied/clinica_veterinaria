import '../model/pet.dart';
import '../persistence/pet_dao.dart';

class PetService {
  final PetDao _petDao = PetDao();

  Future<int> inserirPet(Pet pet) async {
    return await _petDao.inserirPet(pet);
  }

  Future<List<Pet>> listarPets() async {
    return await _petDao.listarPets();
  }

  Future<int> editarPet(Pet pet) async {
    return await _petDao.editarPet(pet);
  }

  Future<void> excluirPet(int? id) async {
    return await _petDao.excluirPet(id);
  }

}