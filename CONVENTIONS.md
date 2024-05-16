# Conventions pour le projet Inote :

*A compléter* au fur et à mesure des besoins :
**Pour chaque ajout imposer une review entre les contributeurs pour qu’ils puissent être informés et se mettre d’accord**

---

## Général

- Nom des variables : ```numberOfProcess ```
- Nom des méthodes : ```createUser()```
- constants : ```MAX_USER_NBR```

## Git

- nom des branches : ```<pseudoGithub>-<purpose>``` exemple: ```fy-customized```

## API REST 

### Javadoc

- Méthode

  ```java
  /**
  * Save validation in database
  *
  * @param user the user to save
  * @author atsuhiko Mochizuki
  * @throws InoteMailException 
  * @throws MailException 
  * @date 2024-03-26
  */
  Validation createAndSave(User user) throws InoteInvalidEmailException, MailException, InoteMailException;
  ```

### Entités

- Hormis le fait de ne pas obligatoirement implémenter Serializable, les entités respecterons la forme Javabean:

  - La classe est simple et ne fait référence à aucun framework particulier
  - La classe ne doit pas être déclarée final
  - La classe contient un Id ne type non primitif -> Integer
  - Les propriétés sont privées et exposées par des Getters/Setters -> @Data
  - Présence d'un constructeur sans arguments -> @NoArgsConstructor
  - *La classe est sérializable -> implements Serializable*
  - La classe implémente les surcharges des méthodes equals() et HashCode() -> @Data

  soit:
  ```java
  @Builder
  @Data
  @NoArgsConstructor
  @AllArgsConstructor 
  @Entity
  @Table(name="user") // si user est un mot réservé, pose problèmes que @Table résoud implicitement
  public class User{
  	@Id
      @GeneratedValue(strategy = GenerationType.IDENTITY)
      private Integer id;
  }
  ```

### Dto

- nom : ```<Purpose>Dto```

- Les dto utiliseront les records Java

- exemple : 
  ```java
  public record CommentDtoResponse(
          Integer id,
          String message,
          Integer UserId
  ) {}
  ```

### Services

- Pour un couplage minimal avec les contrôles, les services exposerons une interface
- Nom service : ```CommentService```
- Nom de son interface : ```CommentServiceImpl```

### Test

- Nom d’une classe de test unitaire: ```<classeTestee>Test```
- Nom d’une classe de test d’intégration :``` <classeTestee>_IT```
- Test unitaire :  
  - Nom du test : ```<nomFonction>__<resultatAttendu>__when<condition>```
    Le test respectera la forme des trois A : Arrange, Act et Assert et devra être annoté de @DisplayName

```java
 @Test
 @DisplayName("Load an user registered in db with username")
 public void loadUserByUsername_shouldReturnUser_whenUserNameIsPresent() {
 /* Arrange */
when(this.userRepository.findByEmail(this.userRef.getUsername())).thenReturn(Optional.of(this.userRef));

/* Act & assert */
assertThat(this.userService.loadUserByUsername(this.userRef.getUsername())).isNotNull();
assertThat(this.userService.loadUserByUsername(this.userRef.getUsername())).isInstanceOf(User.class);
assertThat(this.userService.loadUserByUsername(this.userRef.getUsername())).isEqualTo(this.userRef);

/* Verify */
verify(this.userRepository, times(3)).findByEmail(any(String.class));
}
```



