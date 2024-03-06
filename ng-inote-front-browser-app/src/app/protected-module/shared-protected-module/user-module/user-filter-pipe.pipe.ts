import { Pipe, PipeTransform } from '@angular/core';
import { User } from './user';

@Pipe({
  name: 'userFilterPipe'
})
export class UserFilterPipePipe implements PipeTransform {

  transform(users: User[] | null, searchTerm: string): User[] | null {
    if (!users || !searchTerm) {
      return null;
    }

    let filteredResults: User[] = users.filter(user => {
      return (
        user.pseudo.toLowerCase().includes(searchTerm.toLowerCase()) ||
        user.firstName.toLowerCase().includes(searchTerm.toLowerCase()) ||
        user.lastName.toLowerCase().includes(searchTerm.toLowerCase()) ||
        user.email.toLowerCase().includes(searchTerm.toLowerCase())
      );
    });
    return filteredResults;
  }
}
