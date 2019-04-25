
# Admin
puts 'Creating admin user'
AdminUser.create! email: 'admin@mail.com', password: '123456'

# User
puts 'Creating user'
user  = User.create! name: 'User Base', email: 'user@sifeger.com.br', password: 'lapelalapela'
user2 = User.create! name: 'Karine Silva de Almeida', email: 'karine.silalmeida@gmail.com', password: 'lapelalapela'
user3 = User.create! name: 'Gustavo Escocard', email: 'gustavo.escocard@gmail.com', password: 'lapelalapela'
user4 = User.create! name: 'Etelvira Leite', email: 'etelleite@gmail.com', password: 'Senha12345!'
user5 = User.create! name: 'Dyogo Ribeiro Veiga', email: 'dyogo.nsi@gmail.com', password: 'lapelalapela'
user6 = User.create! name: 'Lucélia Alves', email: 'lucelia.alves@outlook.com', password: 'lapelalapela'

# Project
puts 'Creating project with related users'
project = Project.create! name: 'Projeto Teste', acronyms: 'PT1', description: 'Sample description',
               conclusion_date: '31-03-2030', profiles_attributes: [
                 { role: :owner, user: user},
                 { role: :collaborator, user: user2},
                 { role: :collaborator, user: user3},
                 { role: :collaborator, user: user4},
                 { role: :collaborator, user: user5},
                 { role: :collaborator, user: user6}
               ]

# Requisites
puts 'Creating requisites for project'
req1 = Requisite.create! slg: 'REQ001', kind: 'Funcional', title: 'Requisito Teste 1',
                         description: 'Descrição do requisito de teste 001.', author: user2, responsable: user3,
                         project: project, priority: 'high'
new_requisite = req1.dup.tap do |r|
  r.priority = 'low'
end
req_form1 = RequisiteVersionForm.new(req1, new_requisite.attributes)
req_form1.save!
req1.to_under_evaluation!
req1.to_reject!


req2 = Requisite.create! slg: 'REQ002', kind: 'Funcional', title: 'Requisito Teste 2',
                         description: 'Descrição do requisito de teste 002', author: user2, responsable: user3,
                         project: project, priority: 'medium'
req2.to_under_evaluation!
req2.to_approve!
new_requisite = req2.dup.tap do |r|
  r.priority = 'high'
end
req_form2 = RequisiteVersionForm.new(req2, new_requisite.attributes)
req_form2.save!

req3 = Requisite.create! slg: 'REQ003', kind: 'Funcional', title: 'Requisito Teste 3',
                         description: 'Descrição do requisito de teste 003.', author: user3, responsable: user4,
                         project: project, priority: 'high'
req3.to_under_evaluation!
new_requisite = req3.dup.tap do |r|
  r.responsable = user2
end
req_form3 = RequisiteVersionForm.new(req3, req3.attributes)
req_form3.save!
req3.to_approve!
req3.to_implement!
req3.to_test!
req3.to_conclude!


req4 = Requisite.create! slg: 'REQ004', kind: 'Funcional', title: 'Requisito Teste 4',
                         description: 'Descrição do requisito de teste 004.', author: user3, responsable: user5,
                         project: project, priority: 'medium'
req4.to_under_evaluation!
req4.to_approve!
req4.to_implement!
req4.to_test!

req5 = Requisite.create! slg: 'REQ005', kind: 'Não funcional - Usabilidade', title: 'Requisito Teste 5',
                         description: 'Descrição do requisito de teste 005.', author: user2, responsable: user6,
                         project: project, priority: 'high'
req5.to_under_evaluation!
req5.to_approve!
req5.to_implement!
req5.to_test!

req6 = Requisite.create! slg: 'REQ006', kind: 'Funcional', title: 'Requisito Teste 6',
                         description: 'Descrição do requisito de teste 006.', author: user3, project: project,
                         priority: 'low'
req6.to_under_evaluation!


req7 = Requisite.create! slg: 'REQ007', kind: 'Não funcional - Usabilidade', title: 'Requisito Teste 7',
                         description: 'Descrição do requisito de teste 007.', author: user3, responsable: user2,
                         project: project, priority: 'high'
req7.to_under_evaluation!
req7.to_approve!

req8 = Requisite.create! slg: 'REQ008', kind: 'Funcional', title: 'Requisito Teste 8',
                         description: 'Descrição do requisito de teste 008.', author: user3, responsable: user4,
                         project: project, priority: 'medium'
req8.to_under_evaluation!
req8.to_approve!
req8.to_implement!


req9 = Requisite.create! slg: 'REQ009', kind: 'Funcional', title: 'Requisito Teste 9',
                         description: 'Descrição do requisito de teste 009.', author: user2, project: project,
                         priority: 'low'
req9.to_under_evaluation!

req10 = Requisite.create! slg: 'REQ010', kind: 'Funcional', title: 'Requisito Teste 10',
                          description: 'Descrição do requisito de teste 010.', author: user2, responsable: user6,
                          project: project, priority: 'high'
req10.to_under_evaluation!
req10.to_approve!
req10.to_implement!


Requisite.create! slg: 'REQ011', kind: 'Funcional', title: 'Requisito Teste 11',
                          description: 'Descrição do requisito de teste 011.', author: user3, project: project,
                          priority: 'medium'


Requisite.create! slg: 'REQ012', kind: 'Não funcional - Usabilidade', title: 'Requisito Teste 12',
                          description: 'Descrição do requisito de teste 012.', author: user2, project: project,
                          priority: 'low'


req13 = Requisite.create! slg: 'REQ013', kind: 'Funcional', title: 'Requisito Teste 13',
                          description: 'Descrição do requisito de teste 013.', author: user2, responsable: user4,
                          project: project, priority: 'medium'
req13.to_under_evaluation!
req13.to_approve!

req14 = Requisite.create! slg: 'REQ14', kind: 'Funcional', title: 'Requisito Teste 14',
                          description: 'Descrição do requisito de teste 014.', author: user2, project: project,
                          priority: 'low'
req_form14 = RequisiteVersionForm.new(req14, { slg: 'REQ014' })
req_form14.save!
