<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>ZPareo - Liste de vos examens</title>
        <link type="text/css" rel="stylesheet" href="http://localhost:8080/ZPareo/ressources/css/bootstrap.css" />
        <link type="text/css" rel="stylesheet" href="http://localhost:8080/ZPareo/ressources/css/main.css" />
        <link type="text/css" rel="stylesheet" href="http://localhost:8080/ZPareo/ressources/css/style.css" />
    </head>
    <body>
            <div id="site-conteneur">
                <main>
                    <section id="menu-principal">
						<a href="">Portail ZPareo</a>
						<div id="info-utilisateur">
							<span></span>
							<span><c:out value="${ sessionScope.sessionProfesseur.nom }"></c:out><br/><c:out value="${ sessionScope.sessionProfesseur.prenom }"></c:out></span>
						</div>
						<nav>
							<h2>MENU PRINCIPAL</h2>
							<a href="http://localhost:8080/ZPareo/examen">
					    		<span class="icon-stats"></span>
					    		<span>Examens</span>
					    	</a>
					    </nav>
					    <a href="http://localhost:8080/ZPareo/deconnexion">Deconnexion</a>
					</section>
                    <!--  Conteneur de module -->
                    <div id='module-conteneur'>
                        <!-- Interface de gestion des administrateurs -->
                        <section class="module module-fixe">
                            <div class="module-barre">
                                <h1>Liste de vos examens</h1>
                                <p><c:out value="${ nbExamens }"/> examens enregistr�s</p>
                                <button type="button" class="bouton bouton-success" onclick="affFormCreation('pi/examen',300)">AJOUTER UN EXAMEN</button>
                            </div>
                            <!-- formulaire de recherche de administrateurs -->
                            <form action="http://localhost:8080/ZPareo/pi/examen" method="GET" class="form-inline">
                                <!-- Tableau principal -->
                                <table class="style-1">
                                    <thead>
                                        <tr>
                                            <th><input type="text" name="id" class="form-control input-sm" size="8" pattern="[0-9]+" placeholder="Reference" x-moz-errormessage="Veuillez entrez une r�f�rence correcte"/></th>
                                            <th><input type="date" name="date" class="form-control input-sm" size="7" placeholder="Date" x-moz-errormessage="Veuillez entrer une date correct"/></th>
                                            <th>
                                           		<select name="format" class="form-control input-sm">
                                           			<option disabled="disabled" value="">Format</option>
			         								<option value="0">Tous</option>
			        								<option value="1">Oral</option>
			        								<option value="2">Ecrit</option>
			    								</select>
                                            </th>
                                            <th><input type="text" name="nom" class="form-control input-sm" size="40" pattern=".{5,55}" placeholder="Nom" x-moz-errormessage="Veuillez entrer un nom correct"/></th>
                                            <th>
                                            	<select name="groupe" class="form-control input-sm">
                                            	<option disabled="disabled" value="">Groupe</option>
			         								<option value="">Tous</option>
			        								<c:forEach items="${ sessionScope.sessionProfesseur.listeGroupes }" var="groupe">
			             								<option value="${ groupe.id }">
			            	 								<c:out value="${ groupe.nom }"/>
			            								</option>
			        							 	</c:forEach>
			    								</select>
                                            </th>
                                            <th>
                                            	<select name="matiere" class="form-control input-sm">
                                            		<option disabled="disabled" value="">Mati�re</option>
			         								<option value="">Tous</option>
			        								<c:forEach items="${ sessionScope.sessionProfesseur.listeMatieres }" var="matiere">
			             								<option value="${ matiere.id }">
			            	 								<c:out value="${ matiere.nom }"/>
			            								</option>
			        							 	</c:forEach>
			    								</select>
                                            </th>
                                            <th><input type="text" name="moyenne" class="form-control input-sm" size="10" pattern="[0-9,.]{1,5}" placeholder="Moyenne" x-moz-errormessage="Veuillez entrer un nombre correct"/></th>
                                            <th><button type="submit" class="bouton bouton-primary">RECHERCHER</button></th>
                                        </tr>
                                        <tr>
                                            <th class="sortable">R�f�rence</th>
                                            <th class="sortable">Date</th>
                                            <th class="sortable">format</th>
                                            <th class="sortable">Nom</th>
                                            <th class="sortable">Groupe</th>
                                            <th class="sortable">Mati�re</th>
                                            <th class="sortable">Moyenne</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${ listeExamens }" var="examen" >
                                            <tr>
                                                <td><c:out value="${ examen.id }"/></td>
                                                <td><c:out value="${ examen.date }"/></td>
                                                <td><c:out value="${ examen.format }"/></td>
                                                <td><c:out value="${ examen.nom }"/></td>
                                                <td><c:out value="${ examen.groupe.nom }"/></td>
                                                <td><c:out value="${ examen.matiere.nom }"/></td>
                                                <td><c:out value="${ examen.moyenneGenerale }"/></td>
                                                <td>
                                                    <div class="btn-group">
                                                    	<button type="button" class="bouton bouton-action" onclick="affFormDetails('pi/examen',<c:out value="${ examen.id }"/>,600)"><span class="icon-list2"></span></button>
                                                        <button type="button" class="bouton bouton-action" onclick="affFormEdition('pi/examen',<c:out value="${ examen.id }"/>,600)"><span class="icon-edit"></span></button>
                                                        <a class="unstyled" href="http://localhost:8080/ZPareo/pi/examen/suppression?id=<c:out value="${ examen.id }"/>"><button type="button" class="bouton bouton-action" onclick="return(confirm('Etes vous sur de vouloir supprimer l\'examen : <c:out value="${ examen.nom }"/> ?'));"><span class="icon-trashcan"></span></button></a>
                                                    </div>
                                                </td>
                                            </tr>
                                         </c:forEach>
                                    </tbody>
                                </table>
                            </form>
                        </section>
                    </div>
                </main>
         </div><!-- Fin site-conteneur -->
    <script type="text/javascript" src="http://localhost:8080/ZPareo/ressources/js/jquery.js"></script>
	<script type="text/javascript" src="http://localhost:8080/ZPareo/ressources/js/jquery.tablesorter.min.js"></script> 
	<script type="text/javascript" src="http://localhost:8080/ZPareo/ressources/js/script.js"></script> 
    </body>  
</html>