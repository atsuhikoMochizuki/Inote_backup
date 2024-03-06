export class User {
    id!: number;
    pseudo!: string;
    firstName!: string;
    lastName!: string;
    email!: string;
    phone!: string;
    job!: string;
    password!: string;
    role!: string;
    avatar!: string;
    biography!: string;
    subscriptionDate: Date = new Date;
    teamInCommon!: boolean;
    picture!: Object;

    constructor(
        pseudo: string = '',
        firstName: string = '',
        lastName: string = '',
        email: string = '',
        phone: string = '',
        job: string = '',
        password: string = '',
        role: string = '',
        avatar: string = '../../assets/user.png',
        biography: string = '',
        subscriptionDate: Date = new Date()
    ) {
        this.pseudo = pseudo;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.job = job;
        this.password = password;
        this.role = role;
        this.avatar = avatar;
        this.biography = biography;
        this.subscriptionDate = subscriptionDate;
    }
}