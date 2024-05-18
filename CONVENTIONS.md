# Conventions pour le projet Inote :

*À compléter* au fur et à mesure des besoins :
**pour chaque ajout imposer une revue de code entre les contributeurs pour qu’ils puissent être informés et se mettre d’accord.**

---

## Convention de nommage

### Casses

On a les casses suivantes :
- Nom de classe en *Pascal case* : `MyFirstClass` ;
- Nom de variable en *camel case* : `numberOfProcess` ;
- Nom de méthode en *camel case* : `createUser()` ;
- Nom de constante en *upper snake case*: `MAX_USER_NBR` ;
- Nom de *package* ou de module en *kebab case* : `my-first-package`.

### Nommages

Une méthode correspond à un groupe verbal.

Une variable booléenne correspond à un groupe verbal d’état : `isActivated`, `canBeDestroyed` etc.

Toute autre variable correspond un groupe nominal.

Une interface correspond à une capacité ou un groupe adjectival : `Colorizable`, `AbleToDie` etc.

## Git

### Branches

Toute branche débute en *lower snake case* par un pseudonyme ou ses initiales puis vient le sujet de la branche comme suit :
```my_pseudonyme-the_purpose_to_implement```.
Le sujet de la branche est en Anglais.

La branche `main` est principale.
Toute fusion vers elle exige une requête de tirage et une revue de code.

### Requête de tirage

La requête de tirage débute par un commentaire dont le titre est le sujet de la branche.
Sa validation nécessite la validation par un autre contributeur par revue de code.

## Serveur frontal (Angular)

### Échanges HTTP

Le serveur Angular initiera les requêtes HTTP à l’aide du service `HttpClient` d’Angular qui sera injecté via le constructeur de la classe.
Ce dernier est activé dans l’application par l’import de `HttpClientModule` depuis le module racine dans `src/app/app.module.ts`.

Le lancement d’une requête se fera au sein d’une méthode dans un service dédié. 
Cette dernière : 

- Comportera en arguments les données à envoyer le cas échéant ;
- Devra renvoyer un observable dont le type générique correspondra à l’objet renvoyé dans le corps de la réponse ;
- Implémentera la JSON pour transmettre les données ;
Le cas échéant, elle devra donc contenir l’en-tête HTTP `{ "content-type": "application/json" }` ;
- La méthode comportera l’option `observe` afin de pouvoir accéder à la réponse complète (*body*, *headers*, *status code*…) ;
- Si la requête necessite une authentification elle sera de la forme suivante :
```typescript
const headers = { Authorization: `Bearer ${bearer}` };
```

Nota bene : le *bearer* est le JWT reçu lors de la connexion au service.

Exemple d’un service implémentant des requêtes HTTP :
```typescript
@Injectable()
export class PublicUserService {
  // Http client injection
  constructor(private http: HttpClient) {}

 /**
   * loginUser user
   *
   * @param emailToSend : string
   * @param passwordToSend : string
   *
   * @returns Observable on HttpResponse<CredentialsDto> that contains jwt & refresh-token
   *
   * @author AtsuhikoMochizuki
   * @date 17-05-2024
   */
  loginUser(
    emailToSend: string,
    passwordToSend: string
  ): Observable<HttpResponse<CredentialsDto>> {
    return (
      //Envoi de la requête
      this.http
        // Method type whith type of attempted data in body response
        .post<CredentialsDto>(
          // Url
          BackEndPoints.SIGN_IN,
          //Serialized body data
          JSON.stringify({
                username: emailToSend,
                password: passwordToSend,
          }),
          //Options
          {
            headers: { "content-type": "application/json" },
            observe: "response"
          }
        )
    );
  }
}
```

L’exploitation de la méthode implémentant la requête et retournant un observable :
- Devra prévoir le scénario en cas d’erreur ;
- Devra pouvoir manipuler les informations retournées (*body*, *status*…).

Exemple :
```typescript
/**
   * Login the user
   *
   * @param email:string
   * @param password:string
   *
   * @author AtsuhikoMochizuki
   * @date 17-05-2024
   */
  private login(email: string, password: string) {
    // Service call
    this.publicUserservice
      // Service method call with datas to send in body
      .loginUser(email, password)
      // Observable subscription
      .subscribe(
        // Handle successful response
        (response: HttpResponse<CredentialsDto>) => {
          this.statusAfterRequest = response.status;
          if (this.statusAfterRequest == 200) {
            this.credentialsDto = response.body;
            if (this.credentialsDto)
              this.tokenService.saveToken(this.credentialsDto?.bearer);
            this.router.navigate(["dashboard"]);
          }
        },
        // Handle error
        (error: HttpErrorResponse) => {
          this.statusAfterRequest = error.status;
          this.msgAfterRequest = error.error.detail;
          return throwError(error.message);
        }
      );
  }
```

Autre exemple en utilisant une méthode qui centralise la gestion de l’erreur :
```typescript
private login2(email: string, password: string) {
  // Service call
  this.publicUserservice
    // Service method call with datas to send in body
    .loginUser(email, password)
    .pipe(catchError(this.handleError))
    // Observable subscription
    .subscribe(
      // Handle successful response
      (response: HttpResponse<CredentialsDto>) => {
        this.statusAfterRequest = response.status;
        if (this.statusAfterRequest == 200) {
          this.credentialsDto = response.body;
          if (this.credentialsDto) {
            this.tokenService.saveToken(this.credentialsDto?.bearer);
          }
          this.router.navigate(["dashboard"]);
        }
      },
      // Handle error
      (error: HttpErrorResponse) => {
        this.statusAfterRequest = error.status;
        this.msgAfterRequest = error.error.detail;
        return throwError(error.message);
      }
    );
}

handleError(error: HttpErrorResponse) {
  let errorMessage = "Unknown error!";
  if (error.error instanceof ErrorEvent) {
    // Client-side errors
    errorMessage = `Error: ${error.error.message}`;
  } else {
    // Server-side errors
    errorMessage = `Error Code: ${error.status}\nMessage: ${error.message}`;
  }
  window.alert(errorMessage);
  return throwError(errorMessage);
}
```

### *Data Transfert Objects*

Les noms de ces classes seront suffixés par `Dto` et ils implémenteront une méthode de sérialisation comme suit :
```typescript
export class CredentialsDto {
  public bearer: string;
  public refresh: string;

  constructor(bearer: string, refresh: string) {
    this.bearer = bearer;
    this.refresh = refresh;
  }

  serializedData(): string {
    return JSON.stringify(this);
  }
}
```
### Classes TypeScript

Hormis de très rares cas, les constructeurs des classes TypeScript dans Angular doivent rester vides.
Il ne serviront la plupart du temps qu’à injecter les dépendances.

Toute initialisation d’attribut s’effectuera dans la méthode Angular dédiée à cet effet : `ngOnInit`.

## Serveur dorsal (Spring Boot)

### Échanges HTTP

Les retours de l’API seront gérés par `ResponseEntity`.
Le code de statut HTTP devra être spécifié ainsi :
```java
@GetMapping(path = Endpoint.GET_CURRENT_USER)
public ResponseEntity<PublicUserDto> getCurrentUser(@AuthenticationPrincipal User user)
        throws InoteUserNotFoundException {
    if (user == null) {
        throw new InoteUserNotFoundException();
    }
    PublicUserDto publicUserDto = new PublicUserDto(user.getName(), user.getUsername(), null, user.isActif(),
            user.getRole().getName().toString());
    return ResponseEntity
            .status(HttpStatus.OK)
            .body(publicUserDto);
}
```

### Javadoc

#### Méthodes

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

Hormis le fait de ne pas implémenter obligatoirement `Serializable` les entités respecteront la forme Javabean :
  - La classe est simple et ne fait référence à aucun cadriciel particulier ;
  - La classe ne doit pas être déclarée `final` ;
  - La classe contient une variable `id` annotée `@Id` de type non-primitif `Integer` ;
  - Les propriétés sont privées et exposées par des accesseurs et mutateurs via `@Data` ;
  - La présence d'un constructeur sans arguments annote `@NoArgsConstructor` la classe ;
  - *La classe est sérialisable alors elle doit implémenter `Serializable`* ;
  - La classe qui implémente les surcharges des méthodes `equals()` et `hashCode()` doit être annotée `@Data`.

  On obtient alors ceci :
  ```java
  @Builder
  @Data
  @NoArgsConstructor
  @AllArgsConstructor 
  @Entity
  @Table(name="user") // Si "user" est un mot réservé, pose problèmes que @Table résoud implicitement.
  public class User{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
  }
  ```

### *Data Transfert Objects*

Les DTO sont des registres Java suffixés comme ci-dessous :
```java
public record CommentDtoResponse(
        Integer id,
        String message,
        Integer UserId
) {}
```

Le suffixe peut être `DtoRequest` pour une donnée de requête reçue ou `DtoResponse` pour une donnée de réponse émise.

### Services

Pour un couplage minimal avec les contrôles, les services exposeront une interface.

Le service est suffixé par `Service`.

L’interface porte le nom de son service suffixé par `Impl`.

### Test

Une classe de test unitaire est suffixée par `Test` : `<classeTestee>Test`.

Une classe de test d’intégration est suffixée `_IT` : `<classeTestee>_IT`.

Un méthode de test unitaire est nommée selon la forme des trois A : *Arrange*, *Act* et *Assert* comme ci-dessous :
```<nomFonction>__<resultatAttendu>__when<condition>```.

Elle devra être annotée `@DisplayName`.
Exemple :
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
