import { v } from 'convex/values';
import { mutation, query } from './_generated/server';

export const get = query({
  args: {},
  handler: async (ctx) => {
    return await ctx.db.query('tasks').collect();
  },
});

export const create = mutation({
  args: {
    title: v.string(),
    description: v.optional(v.string()),
    createdAt: v.string(),
    isCompleted: v.boolean(),
    priority: v.number(),
    category: v.number(),
  },
  handler: async (ctx, args) => {
    const newTaskId = await ctx.db.insert('tasks', { ...args });
    return newTaskId;
  },
});
