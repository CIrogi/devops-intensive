import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';

interface User {
  id?: number;
  name: string;
  email: string;
}

const API_BASE = '/api/users';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent implements OnInit {
  users: User[] = [];
  form: User = { name: '', email: '' };
  loading = false;
  error = '';

  constructor(private readonly http: HttpClient) {}

  ngOnInit(): void {
    this.loadUsers();
  }

  loadUsers(): void {
    this.loading = true;
    this.error = '';

    this.http.get<User[]>(API_BASE).subscribe({
      next: (users) => {
        this.users = users ?? [];
        this.loading = false;
      },
      error: () => {
        this.error = 'Unable to reach the API. Is the Java backend running?';
        this.loading = false;
      },
    });
  }

  createUser(): void {
    if (!this.form.name.trim() || !this.form.email.trim()) {
      this.error = 'Name and email are required.';
      return;
    }

    this.http.post<User>(API_BASE, this.form).subscribe({
      next: (created) => {
        this.form = { name: '', email: '' };
        this.error = '';
        if (created) {
          this.users = [created, ...this.users];
          return;
        }
        this.loadUsers();
      },
      error: () => {
        this.error = 'Create failed. Check the API logs for details.';
      },
    });
  }
}
