package models;

import java.util.Set;

public class Etudiant extends Utilisateur implements Comparable<Etudiant>
{
	private Groupe groupe;
	private Set<Note> listeNote;

	public Etudiant()
	{
		super();
	}
	public Groupe getGroupe() 
	{
		return groupe;
	}
	
	public void setGroupe(Groupe groupe) 
	{
		this.groupe = groupe;
	}
	
	public Set<Note> getListeNote() 
	{
		return listeNote;
	}
	
	public void setListeNote(Set<Note> listeNote) 
	{
		this.listeNote = listeNote;
	}
	
	@Override
	public int compareTo(Etudiant etudiant2) 
	{
		int compId = this.getId().compareTo(etudiant2.getId());
        if(compId != 0) return compId;
        return 0;
	}
}