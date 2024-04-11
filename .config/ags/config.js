const hyprland = await Service.import("hyprland");
const battery = await Service.import("battery");
const audio = await Service.import("audio");

const date = Variable("", {
  poll: [1000, 'date "+%H:%M:%S %b %e."'],
});

function Workspaces() {
  const activeId = hyprland.active.workspace.bind("id");
  const workspaces = hyprland.bind("workspaces").as((ws) =>
    ws.map(({ id }) =>
      Widget.Button({
        on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
        child: Widget.Label(`${id}`),
        class_name: activeId.as((i) => `${i === id ? "focused" : ""}`),
      }),
    ),
  );

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
}

function Center() {
  return Widget.Box({
    spacing: 8,
    children: [Workspaces()],
  });
}

function Bar(monitor = 0) {
  return Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: "bar",
    monitor,
    anchor: ["bottom", "left", "right"],
    child: Widget.CenterBox({
      center_widget: Center(),
    }),
  });
}

App.config({
  style: "./style.css",
  windows: [Bar()],
});

export {};
