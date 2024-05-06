package de.sayk.web;

import java.io.File;
import java.io.Serializable;
import java.rmi.RemoteException;

import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.context.FacesContext;

import org.primefaces.PrimeFaces;
import org.primefaces.model.menu.DefaultMenuItem;
import org.primefaces.model.menu.DefaultMenuModel;
import org.primefaces.model.menu.DefaultSubMenu;
import org.primefaces.model.menu.MenuModel;

import de.sayk.ClientListener;
import de.sayk.Dir;
import de.sayk.MesTestClient;
import de.sayk.ServerStartupListener;
import de.sayk.data.BigData;
import de.sayk.data.Database;
import de.sayk.logging.Logger;

@ManagedBean
@ApplicationScoped
public class MenuView implements Serializable, ClientListener {

	private static final long serialVersionUID = 1L;
	private static Logger log = Logger.getLogger(MenuView.class.getName());

	private String[] lsen = { "n.n", "n.n", "n.n", "n.n", "n.n" };
	private MesTestClient mtc = null;

	private MenuModel model;

	@PostConstruct
	public void init() {

		model = new DefaultMenuModel();

		try {
			ServerStartupListener.ms.addClientListener(this);
		} catch (RemoteException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		try {
			String sqlFolder = Dir.getHomePath() + "sql";

			// First submenu
			DefaultSubMenu firstSubmenu = DefaultSubMenu.builder().label("Lernsituationen").build();

			DefaultMenuItem item;

			int j = 0;
			File[] files = new File(sqlFolder).listFiles();
			for (File file : files) {
				if (file.isFile() && file.getName().endsWith(".sql")) {
					lsen[j++] = file.getName();
					if (j > 4)
						break;
				}
			}

			for (int i = 0; i < lsen.length; i++) {
				item = DefaultMenuItem.builder().value(lsen[i]).icon("pi pi-refresh").command("#{menuView.ls" + i + "}")
						.update("messages").build();
				firstSubmenu.getElements().add(item);
			}

			model.getElements().add(firstSubmenu);

			// Second submenu
			DefaultSubMenu secondSubmenu = DefaultSubMenu.builder().label("Funktionen").build();

			item = DefaultMenuItem.builder().value("Neuen Auftrag anlegen...").icon("pi pi-external-link")
					.url("http://192.168.0.15:8042/neworder").build();
			secondSubmenu.getElements().add(item);

			item = DefaultMenuItem.builder().value("Starte Test SPS").icon("pi pi-server")
					.command("#{menuView.startSPS}").update("messages").build();
			secondSubmenu.getElements().add(item);

			item = DefaultMenuItem.builder().value("Stoppe Test SPS").icon("pi pi-power-off")
					.command("#{menuView.stopSPS}").update("messages").build();
			secondSubmenu.getElements().add(item);

			model.getElements().add(secondSubmenu);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public MenuModel getModel() {
		return model;
	}

	public void startSPS() {
		addMessage("startSPS", "SPS Client gestartet");
		if (mtc == null) {
			mtc = new MesTestClient();
			mtc.start();
		}
	}

	public void stopSPS() {
		addMessage("stoppeSPS", "SPS Client gestartet");
		if (mtc != null) {
			mtc.interruptAll();
			mtc = null;
		}
	}

	// blöd, aber in JSF lassen sich keine Parameter in Methodeaufrufen übergeben!
	public void ls0() {
		addMessage("SQL Skript", lsen[0]);
		startScript(0);
	}

	public void ls1() {
		addMessage("SQL Skript", lsen[1]);
		startScript(1);
	}

	public void ls2() {
		addMessage("SQL Skript", lsen[2]);
		startScript(2);
	}

	public void ls3() {
		addMessage("SQL Skript", lsen[3]);
		startScript(3);
	}

	public void ls4() {
		addMessage("SQL Skript", lsen[4]);
		startScript(4);
	}

	private void startScript(int i) {

		Database.setup(Dir.getHomePath() + "sql/" + lsen[i]);

		ServerStartupListener.ms.refreshAllPartsInStore();

		if (lsen[i].equals("Data Intelligence.sql"))
			BigData.addProductionData();

		FacesContext facesContext = FacesContext.getCurrentInstance();
		if (facesContext != null) {
			log.debug("Upadte gestartet...");
			PrimeFaces.current().ajax().update("idHeader:lager");
			PrimeFaces.current().ajax().update("idPlanedOrder:table");
		}
	}

	public void addMessage(String summary, String detail) {

		FacesContext context = FacesContext.getCurrentInstance();

		FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_INFO, summary, detail);

		if (context == null) {
			// Diese Methode kann nur innerhalb eines JSF-Lifecycle aufgrufen werden.
			// Wie dieser durch ein Event vom Server gestartet wird habe ich noch nicht
			// verstanden ;-(

		} else {
			context.addMessage(null, message);
		}

	}

	@Override
	public void newClientRequest(int mid, String name, String ip, String request) throws RemoteException {
		addMessage(name, request);
	}
}