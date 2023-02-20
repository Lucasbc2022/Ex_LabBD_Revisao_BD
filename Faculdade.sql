CREATE DATABASE faculdade
GO

USE faculdade
GO

CREATE TABLE Aluno (
RA                INT                          NOT NULL,
Nome              VARCHAR(100)                 NOT NULL,
Idade             INT             CHECK(Idade > 0)          NOT NULL
PRIMARY KEY(RA) 
)    
GO

CREATE TABLE Disciplina (
Codigo            INT             NOT NULL,
Nome              VARCHAR(80)     NOT NULL,
Carga_Horaria     INT             CHECK(Carga_Horaria >= 32)      NOT NULL
PRIMARY KEY(Codigo)        
)
GO



CREATE TABLE Aluno_Disciplina (
DisciplinaCodigo            INT             NOT NULL,
AlunoRA                     INT             NOT NULL
PRIMARY KEY(DisciplinaCodigo, AlunoRA)
FOREIGN KEY(DisciplinaCodigo) REFERENCES Disciplina(Codigo),
FOREIGN KEY(AlunoRA) REFERENCES Aluno(RA)
)
GO







CREATE TABLE Curso (
Codigo                      INT             NOT NULL,
Nome                        VARCHAR(50)     NOT NULL,
Area                        VARCHAR(50)     NOT NULL
PRIMARY KEY(Codigo)
)
GO




CREATE TABLE Curso_Disciplina (
DisciplinaCodigo            INT             NOT NULL,
CursoCodigo                 INT             NOT NULL
PRIMARY KEY(DisciplinaCodigo, CursoCodigo)
FOREIGN KEY(CursoCodigo) REFERENCES Curso(Codigo),
FOREIGN KEY(DisciplinaCodigo) REFERENCES Disciplina(Codigo)
)
GO

CREATE TABLE Titulacao (
Codigo                  INT              NOT NULL,
Titulo                  VARCHAR(40)      NOT NULL
PRIMARY KEY(Codigo)
)
GO

CREATE TABLE Professor (
Registro                 INT               NOT NULL,
Nome                     VARCHAR(100)      NOT NULL,
Titulacao                INT               NOT NULL
PRIMARY KEY(Registro)
FOREIGN KEY(Titulacao) REFERENCES Titulacao(Codigo)
)
GO

CREATE TABLE Disciplina_Professor (
DisciplinaCodigo        INT                 NOT NULL,
ProfessorRegistro       INT                 NOT NULL
PRIMARY KEY(DisciplinaCodigo, ProfessorRegistro)
FOREIGN KEY(DisciplinaCodigo) REFERENCES Disciplina(Codigo),
FOREIGN KEY(ProfessorRegistro) REFERENCES Professor(Registro)
)
GO







--Como fazer as listas de chamadas, com RA e nome por disciplina ?

SELECT a.RA,
       a.Nome
FROM Aluno a, Aluno_Disciplina ad, Disciplina d
WHERE a.RA = ad.AlunoRA
      AND ad.DisciplinaCodigo = d.Codigo 

--Fazer uma pesquisa que liste o nome das disciplinas e o nome dos professores que as ministram
SELECT d.Nome,
       p.Nome 
FROM Disciplina d, Disciplina_Professor dp, Professor p
WHERE d.Codigo = dp.DisciplinaCodigo
      AND dp.ProfessorRegistro = p.Registro



--Fazer uma pesquisa que , dado o nome de uma disciplina, retorne o nome do curso

SELECT d.Nome,
       c.Nome
FROM Disciplina d, Curso_Disciplina cd, Curso c
WHERE d.Codigo = cd.DisciplinaCodigo
      AND cd.CursoCodigo = c.Codigo
 




--Fazer uma pesquisa que , dado o nome de uma disciplina, retorne sua área

SELECT d.Nome,
       c.Area
FROM  Disciplina d, Curso_Disciplina cd, Curso c
WHERE d.Codigo = cd.DisciplinaCodigo
      AND cd.CursoCodigo = c.Codigo



--Fazer uma pesquisa que , dado o nome de uma disciplina, retorne o título do professor que a ministra
SELECT d.Nome,
       t.Titulo
FROM Disciplina d, Disciplina_Professor dp, Professor p, Titulacao t
WHERE d.Codigo = dp.DisciplinaCodigo
      AND dp.ProfessorRegistro = p.Registro
	  AND p.Titulacao = t.Codigo




--Fazer uma pesquisa que retorne o nome da disciplina e quantos alunos estão matriculados em cada uma delas
SELECT d.Nome,
       COUNT(ad.AlunoRA) AS qtd_alunos
FROM Aluno a, Aluno_Disciplina ad, Disciplina d
WHERE a.RA = ad.AlunoRA
      AND ad.DisciplinaCodigo = d.Codigo
GROUP BY d.Nome



/*Fazer uma pesquisa que, dado o nome de uma disciplina, retorne o nome do professor.  
  Só deve retornar de disciplinas que tenham, no mínimo, 5 alunos matriculados
*/
SELECT d.Nome,
       p.Nome       
FROM Disciplina d, Disciplina_Professor dp, Professor p, Aluno a, Aluno_Disciplina ad
WHERE d.Codigo = dp.DisciplinaCodigo
      AND dp.ProfessorRegistro = p.Registro
	  AND d.Codigo = ad.DisciplinaCodigo
	  AND ad.AlunoRA = a.RA
GROUP BY d.Nome, p.Nome
HAVING COUNT(ad.AlunoRA) >= 5





/*Fazer uma pesquisa que retorne o nome do curso e a quatidade de
  professores cadastrados que ministram aula nele. A coluna de ve se chamar quantidade
*/
SELECT c.Nome,
       COUNT(dp.ProfessorRegistro) AS quantidade
FROM Curso c, Curso_Disciplina cd, Professor p, Disciplina_Professor dp, Disciplina d
WHERE c.Codigo = cd.CursoCodigo
      AND cd.DisciplinaCodigo = d.Codigo
	  AND d.Codigo = dp.DisciplinaCodigo
	  AND dp.ProfessorRegistro = p.Registro
GROUP BY c.Nome



SELECT * FROM Curso_Disciplina
SELECT * FROM Curso
SELECT * FROM Disciplina_Professor
SELECT * FROM Disciplina
SELECT * FROM Professor


SELECT * FROM Aluno 
SELECT * FROM Aluno_Disciplina
SELECT * FROM Titulacao



