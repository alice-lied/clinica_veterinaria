import '../model/pet.dart';
import '../persistence/pet_dao.dart';


class PetService {
  final PetDao _petDao = PetDao();

  Future<int> addPet(Pet pet) async {
    return await _petDao.insertPet(pet);
  }

  Future<List<Pet>> getPets() async {
    return await _petDao.getAllPets();
  }
}