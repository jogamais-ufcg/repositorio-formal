module JogaMaisUFCG
 
  one sig System {
    users: set User,
    courts: set Court
  }
 
  sig User {
    appointments: disj some Appointment,
  }
 
  sig Appointment {
    court: one Court,
    date: one Date
  }

  sig Court {
    rules: set Rule
  }

  sig Rule {}

  sig Date {}
 
  fact SystemRules {
 
    // Cria os usuários do sistema
    all u: User, s: System | u in s.users
 
    // Garante que o sistema deve ter ao menos um usuário
    one s: System | #(s.users) > 1
 
    // Cria uma lista de quadras no sistema  
    all c: Court, s: System | c in s.courts
 
    // Garante que toda quadra possua ao menos uma regra
    all c: Court | #(c.rules) > 0

    // Garante que todos as reservas possuam um usuário associado
    all a: Appointment | some u: User | a in u.appointments

    // Duas reservas com a mesma quadra não podem ter a mesma data
    all disj a1, a2: Appointment | a1.court = a2.court implies a1.date != a2.date

    // Garante que toda data possua uma reserva
    all d: Date | some a: Appointment | a.date = d
  }
 
  pred show[] {}

  run show for 3
